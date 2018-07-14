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

        // Database code goes here

        return nil
    }

}
