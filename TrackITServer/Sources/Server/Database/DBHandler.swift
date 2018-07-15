//
// File         : DBHandler.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-14
//

import Foundation
import NetConnect
import Database
import SwiftyJSON


class DBHandler : Handler {

    /// Entry point for database handler.
    override func main(packet: NodePacket) throws -> Data? {
        defer {
            self.destroy()
        }
        if packet.flags.get(MessageFlags.SpecialRequest) {
            Log.verbose("Handling special request", event: .server)
            guard let requestString = packet.message.string else {
                return nil
            }
            let splitString = requestString.split(separator: ":")
            guard splitString.count > 0 else {
                return nil
            }
            guard let request = SpecialRequests(rawValue: String(splitString[0]))
            else {
                return nil
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
                let table = try cnf.getNutrientValues(for: id)
                return try table.columnsAsJSON().rawData()

            }
        } else {
            guard let sqlStatement = packet.message.string else {
                return nil
            }

            guard let db = Database(path: "./cnf.db") else {
                throw Database.Error.UnableToOpen
            }
            let table = try db.query(sqlStatement)
            return try table.rowsAsJSON().rawData()
        }
    }

}
