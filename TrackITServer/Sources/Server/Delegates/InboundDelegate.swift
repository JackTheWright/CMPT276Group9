//
// File         : InboundDelegate.swift
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

class InboundDelegate : NodeDelegate {

    weak var socket: UDPSocket!

    weak var active: Atomic<Bool>!

    weak var messageQueue: ThreadedQueue<NodePacket>!

    required init() { }

    func start() {
        let port = Config.port
        Log.verbose("Inbound Node Activated; port = \(port)", event: .info)
        while active.load() {
            do {
                let readData = try socket.listen(on: port)
                guard let message = Message(from: readData.data) else {
                    throw NetworkError.MalformedMessage
                }

                DispatchQueue.global().async {
                    let packet = NodePacket(
                            address: readData.address,
                            message: message,
                            time: Time.now
                    )
                    Log.verbose("Inbound Node: Message Received", event: .info)
                    self.messageQueue.enqueue(packet)
                }
            } catch let error {
                // Performed asynchronously so that the node is not held up
                // writing error messages while it should be receiving incoming
                // connections.
                DispatchQueue.global(qos: .background).async {
                    switch error {
                    case let ne as NetworkError:
                        Log.event(
                                "Inbound Node Network Error: " + ne.description,
                                event: .warning
                        )

                    case let se as Socket.Error:
                        Log.event(
                                "Inbound Node Socket Error: " + se.description,
                                event: .warning
                        )

                    default:
                        Log.event(
                                "Inbound Node Error: An exception was thrown",
                                event: .warning
                        )
                    }
                }
            }
        }
    }

    func didEnd() {
        Log.verbose("Inbound Node Deactivated", event: .info)
    }

}
