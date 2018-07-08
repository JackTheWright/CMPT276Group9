//
// File         : InboundDelegate.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-09
//

import Foundation

class Server {

    let inboundNode: InboundNode

    let outboundNode: OutboundNode

    init?() {
        Log.verbose("Initializing Server Instance", event: .info)
        guard let inNode = InboundNode() else {
            return nil
        }
        guard let outNode = OutboundNode() else {
            return nil
        }
        inboundNode = inNode
        outboundNode = outNode
    }

    func start() {
        inboundNode.activate()
        outboundNode.activate()
    }

    func stop() {
        inboundNode.deactivate()
        outboundNode.deactivate()
    }

}
