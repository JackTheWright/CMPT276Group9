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

    /// Handshake responses are not encrypted.
    override func didCreate() {
        cryptographer = nil
    }

    /// Outbound messages have no body.
    override func main(packet: NodePacket) throws -> Data? {
        // TODO: Optionally add a verification step here
        return Data()
    }

    /// Creates special flags for handshake response messages.
    ///
    /// - returns: `HSConfirm` flag if no error and `HSDeny` flag if error.
    override func getMessageFlags(isError: Bool) -> Message.Flags {
        var flags = Message.Flags()
        if isError {
            flags.set(MessageFlags.HSDeny)
        } else {
            flags.set(MessageFlags.HSConfirm)
        }
        return flags
    }

    /// Assigns a new identifier from the router to all outbound messages.
    override func getOutboundId() -> Message.ID? {
        return super.getNewIdFromRouter()
    }

}
