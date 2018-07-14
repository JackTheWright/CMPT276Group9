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

    override func main(packet: NodePacket) throws -> Data? {
        let flags = packet.message.flags
        guard let sqlStatement = packet.message.string else {
            return nil
        }

        // Database code goes here

        return nil
    }

}
