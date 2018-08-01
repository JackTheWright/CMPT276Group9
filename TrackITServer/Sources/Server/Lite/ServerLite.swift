//
// File         : ServerLite.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-30
//

import Foundation
import NetConnect
import Database
import SwiftyJSON

/// A slimmed down, non-scalable version of the main `Server` class.
class ServerLite {

    /// The server's network socket.
    static let socket = StreamingSocket()!

    /// The server's database reference.
    static let database = Database(path: "./cnf.db")!

    /// Starts the server's runtime loop.
    ///
    /// - parameters:
    ///     - port: The port to run the server on.
    ///
    ///     - cryptographer: An optional cryptographer delegate which will
    ///         encrypt / decrypt outgoing and incoming messages respectively.
    static func start(port: Int, cryptographer: Cryptographer? = nil) {
        socket.timeout = nil
        while true {
            do {

                // Receive Message
                var readData = try socket.listen(on: port)
                if let crypt = cryptographer {
                    readData.data = try crypt.decrypt(readData.data)
                }
                Log.verbose(
                        "Received \(readData.data.count) bytes",
                        event: .server
                )
                guard readData.data.count != 0 else {
                    throw NetworkError.Timeout
                }
                guard let message = Message(from: readData.data) else {
                    throw NetworkError.MalformedMessage
                }

                // Process Inbound Message
                var outData: Data? = nil

                // Echo Handler
                if message.flags.get(MessageFlags.Echo) {
                    outData = try echoHandler(message)
                }

                // SQLite Special Request Handler
                else if message.flags.get(MessageFlags.SpecialRequest) {
                    guard let str = message.string else {
                        throw NetworkError.MalformedMessage
                    }
                    outData = try specialDBRequest(requestString: str)
                }

                // SQLite Database Handler
                else if message.flags.get(MessageFlags.DBQuery) {
                    guard let query = message.string else {
                        throw Database.Error.InvalidCommand
                    }
                    outData = try databaseHandler(query: query)
                }

                // Send Reply
                if var od = outData {
                    if let crypt = cryptographer {
                        od = try crypt.encrypt(od)
                    }
                    let outMessage = Message(od, flags: Message.Flags(), id: 0)
                    Log.verbose(
                            "Writing \(od.count) bytes to sender",
                            event: .server
                    )
                    try socket.write(
                            data: outMessage.rawData,
                            to: readData.sender
                    )
                }

            } catch let e {
                print(String(describing: e))
            }
        }
    }

    /// Simple echo handler. Echos the inbound message back to the sender.
    ///
    /// - parameters:
    ///     - message: The inbound message to echo back.
    ///
    /// - returns: The same data that was in the body of the input message.
    static func echoHandler(_ message: Message) throws -> Data? {
        let echo = message.body
        Log.verbose("Echoing \(echo.count) bytes", event: .server)
        return echo
    }

    /// Database query handler. Actual querying is offloaded onto the server's
    /// `Database` object.
    ///
    /// - parameters:
    ///     - query: An SQLite query to pass to the database.
    ///
    /// - returns: The resulting table encoded in JSON.
    static func databaseHandler(query: String) throws -> Data? {
        Log.verbose("Handling SQL query: \(query)", event: .server)
        let table = try database.query(query)
        return try table.rowsAsJSON().rawData()
    }

    /// Database special request handler. Handles more complex database queries.
    /// Offloads most of this work onto a `NutrientFile` object.
    ///
    /// - parameters:
    ///     - requestString: The body of the special request message.
    ///
    /// - returns: The result of the request encoded in JSON.
    static func specialDBRequest(requestString: String) throws -> Data? {
        Log.verbose("Handling special request \(requestString)", event: .server)
        let splitString = requestString.split(separator: ":")
        guard splitString.count > 0 else {
            throw NetworkError.MalformedMessage
        }
        guard let request =
        SpecialRequests(rawValue: String(splitString[0]))
                else {
            throw NetworkError.MalformedMessage
        }

        switch (request) {

        case .CNFGetAllFoodItems:
            guard let cnf = NutrientFile(path: Config.cnfPath) else {
                Log.event("Unable to locate \(Config.cnfPath)",
                        event: .warning)
                return nil
            }
            let table = try cnf.getAllFoodNames()
            return try table.rowsAsJSON().rawData()

        case .CNFGetNutrients:
            guard splitString.count >= 2 else {
                Log.event("Invalid message body for get nutrients",
                        event: .warning)
                return nil
            }
            guard let id = Int(splitString[1]) else {
                return nil
            }
            guard let cnf = NutrientFile(path: Config.cnfPath) else {
                Log.event("Unable to locate \(Config.cnfPath)",
                        event: .warning)
                return nil
            }
            guard id > 0 else {
                return nil
            }
            let table = try cnf.getNutrientValues(for: id)
            return try table.columnsAsJSON().rawData()
        }
    }

}
