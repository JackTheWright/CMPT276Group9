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

    /// Path to Canadian Nutrient File data base.
    let cnfPath = Config.cnfPath

    /// Path to user information database.
    let userDBPath = Config.userDBPath

    /// Entry point for database handler.
    override func main(packet: NodePacket) throws -> Data? {
        defer {
            self.destroy()
        }
        guard let sqlStatement = packet.message.string else {
            return nil
        }

        guard let db = Database(path: cnfPath) else {
            throw Database.Error.UnableToOpen
        }
        let table = try db.query(sqlStatement)
        return try table.rowsAsJSON().rawData()
    }

}
