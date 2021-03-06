//
// File         : Router.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-08
//

import Foundation
import NetConnect
import Threading

class Router {

    /// A weak reference to the inbound message queue which is located in the
    /// encapsulating server's inbound node.
    ///
    /// The router's main logic loop will continuously dequeue packets from
    /// this queue and send them to their respective handlers.
    weak var inboundQueue: ThreadedQueue<NodePacket>!

    /// A weak reference to the outbound message queue which is located in the
    /// encapsulating server's outbound node.
    ///
    /// The router's handlers will be directly pushing outbound packets to this
    /// queue.
    weak var outboundQueue: ThreadedQueue<NodePacket>!

    /// A cryptographer delegate supplied by the server.
    var cryptographer: Cryptographer?

    /// The conversation identifier for the handshake handler.
    var handshakeId: Message.ID {
        return Message.handshakeId
    }

    /// The set of all active handlers in the router.
    var handlers = ThreadedDictionary<Int, HandlerComplex>()

    var active = Atomic<Bool>(false)

    /// A map of handler ids to their active state. `true` is active, `false` is
    /// inactive.
    fileprivate var handleIds = [Bool](repeating: false, count: 1000)


}

// MARK: Init Methods

extension Router {

    /// Called once by the server to active the router.
    ///
    /// Initialization and other setup is performed here.
    func activate() {
        var handshakeHandler = HandshakeHandler(id: handshakeId)
        configureHandler(&handshakeHandler)
        handlers[Int(handshakeId)] = (
                handshakeHandler,
                HandlerState.idle,
                DispatchQueue(label: LabelDispatch.getLabel())
        )

        active.store(true)
    }

    /// Starts the router's main logic loop.
    func start() {
        while active.load() {
            if inboundQueue.count > 0 {
                let packet = inboundQueue.dequeue()
                let id = packet.id
                let idx = Int(id)
                Log.verbose("Routing msg: id = \(id)", event: .server)
                if let hc = handlers[idx] {
                    // If the handler already exists, run it.
                    handlers[Int(id)]!.state = .active
                    let handler = hc.handler
                    hc.dispatch.async {
                        handler.execute(packet: packet)
                        if self.handlers[idx]!.state != .awaitingDestruction {
                            self.handlers[idx]!.state = .idle
                        } else {
                            Log.verbose(
                                    "Destroying handler: id = \(id)",
                                    event: .server
                            )
                            self.handlers[idx] = nil
                            self.handleIds[idx] = false
                        }
                    }
                } else {
                    // If handler doesn't exist, create it then run it.
                    let id = generateHandlerId()
                    let idx = Int(id)
                    // TODO: generate handler from message flags
                    if var handler = generateHandler(flags: packet.flags, id: id) {
                        configureHandler(&handler)

                        Log.verbose("Created handler: id = \(id)", event: .server)
                        let hc: HandlerComplex = (
                                handler as Handler,
                                HandlerState.active,
                                DispatchQueue(label: LabelDispatch.getLabel())
                        )
                        handlers[idx] = hc
                        hc.dispatch.async {
                            handler.execute(packet: packet)
                            if self.handlers[idx]!.state != .awaitingDestruction {
                                self.handlers[idx]!.state = .idle
                            } else {
                                self.handlers[idx] = nil
                            }
                        }
                    }
                }
            }
        }
    }

}

// MARK: Runtime Methods

extension Router {

    /// Marks a handler with a given id for destruction.
    func markHandlerForDestruction(id: Message.ID) {
        handlers[Int(id)]?.state = .awaitingDestruction
    }

    /// Returns the next available handler id and sets that id to be active.
    func generateHandlerId() -> UInt16 {
        for i in 0..<handleIds.count {
            if !handleIds[i] {
                handleIds[i] = true
                return UInt16(i)
            }
        }
        return 0
    }

    /// Generates and returns a handler based on the flags of a message.
    func generateHandler(flags: Message.Flags, id: Message.ID) -> Handler? {
        if flags.get(MessageFlags.DBQuery) || flags.get(MessageFlags.DBAction) {
            Log.verbose("Creating Database Handler", event: .server)
            return DBHandler(id: id)
        }

        else if flags.get(MessageFlags.Echo) {
            Log.verbose("Creating Echo Handler", event: .server)
            return EchoHandler(id: id)
        }

        else {
            Log.verbose(
                    "Unable to create handler for: id = \(id)  flags = \(flags.rawValue)",
                    event: .server
            )
            return nil
        }
    }

}

// MARK: Types

extension Router {

    /// A tuple containing a handler instance along with some metadata.
    typealias HandlerComplex = (
            handler: Handler,           // Handler instance
            state: HandlerState,        // State of the handler
            dispatch: DispatchQueue     // Dispatch queue to execute handler on
    )

    /// Enumeration of possible states for a handler instance.
    enum HandlerState {
        case idle
        case active
        case awaitingDestruction
    }

}

