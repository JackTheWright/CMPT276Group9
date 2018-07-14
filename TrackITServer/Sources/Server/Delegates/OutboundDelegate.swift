//
// File         : OutboundDelegate.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation
import NetConnect
import Threading
import Socket

class OutboundDelegate : NodeDelegate {

    weak var socket: UDPSocket!

    weak var active: Atomic<Bool>!

    weak var messageQueue: ThreadedQueue<NodePacket>!

    required init() { }

    func start() {
        Log.verbose("Outbound Node Activated", event: .info)
        while active.load() {
            if let packet = messageQueue.safeDequeue() {
                Log.verbose(
                        "Outbound Node: Sending Packet; ID = \(packet.id)",
                        event: .info
                )
                do {
                    try socket.write(
                            data: packet.message.rawData,
                            to: packet.address
                    )
                } catch let error {
                    switch error {

                    case let se as Socket.Error:
                        Log.event(
                                "Outbound Node Socket Error: " + se.description,
                                event: .warning
                        )

                    default:
                        Log.event(
                                "Outbound Node Error: An exception was thrown",
                                event: .warning
                        )

                    }
                }
            }
        }
    }

    func didEnd() {
        Log.verbose("Outbound Node Deactivated", event: .info)
    }

}
