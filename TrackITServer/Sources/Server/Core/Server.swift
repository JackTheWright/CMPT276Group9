//
// File         : InboundDelegate.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-09
//

import Foundation
import NetConnect

class Server {

    let inboundNode: InboundNode

    let outboundNode: OutboundNode

    let router: Router

    let socket: UDPSocket

    init?() {
        Log.verbose("Initializing Server Instance", event: .info)
        guard let s = try? UDPSocket() else {
            return nil
        }
        socket = s
        guard let inNode = InboundNode(socket: socket) else {
            return nil
        }
        guard let outNode = OutboundNode(socket: socket) else {
            return nil
        }
        inboundNode = inNode
        outboundNode = outNode
        router = Router()
        router.inboundQueue = inboundNode.messageQueue
        router.outboundQueue = outboundNode.messageQueue
    }

    func start() {
        inboundNode.activate()
        outboundNode.activate()
        router.activate()
        router.start()
    }

    func stop() {
        inboundNode.deactivate()
        outboundNode.deactivate()
    }

}
