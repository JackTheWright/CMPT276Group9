//
// File         : NodePacket.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-08
//

import Foundation
import NetConnect

struct NodePacket {

    let address: Address
    let message: Message
    let time: Time

    var flags: Message.Flags {
        return message.flags
    }

    var id: Message.ID {
        return message.id
    }

}
