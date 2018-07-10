//
// File         : HandshakeHandler.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-08
//

import Foundation
import NetConnect

class HandshakeHandler : Handler {

    override func didCreate() {
        cryptographer = nil
    }

    override func main(packet: NodePacket) throws -> Data? {
        return Data()
    }

    override func getMessageFlags(isError: Bool) -> Message.Flags {
        var flags = Message.Flags()
        if isError {
            flags.set(MessageFlags.HSDeny)
        } else {
            flags.set(MessageFlags.HSConfirm)
        }
        return flags
    }

}
