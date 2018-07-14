//
// File         : EchoHandler.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-08
//

import Foundation
import NetConnect

/// Sample handler which simply sends back the contents of the inbound message.
class EchoHandler : Handler {

    override func didCreate() {
        cryptographer = nil
    }

    override func main(packet: NodePacket) throws -> Data? {
        if let msg = packet.message.string {
            Log.verbose("Echo: \(msg)", event: .server)
            return msg.data(using: .utf8)
        } else {
            return nil
        }
    }

}
