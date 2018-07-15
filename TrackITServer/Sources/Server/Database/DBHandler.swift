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
