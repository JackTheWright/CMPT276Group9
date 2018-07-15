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
import PerfectSQLite
import SwiftyJSON

class DBHandler : Handler {

    /// Path to Canadian Nutrient File data base.
    let cnfPath = Config.cnfPath

    /// Path to user information database.
    let userDBPath = Config.userDBPath

    /// Entry point for database handler.
    override func main(packet: NodePacket) throws -> Data? {
        let flags = packet.message.flags
        guard let sqlStatement = packet.message.string else {
            return nil
        }

        Log.verbose("Executing SQL Statement: \(sqlStatement)", event: .server)
        if let json = try? JSON(arrayLiteral: "a", "b", "c", "d").rawData() {
            return json
        } else {
            return Data()
        }
    }

}
