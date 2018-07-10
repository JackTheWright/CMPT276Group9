//
// File         : Handler.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-08
//

import Foundation
import NetConnect
import Threading

class Handler {

    let id: Int

    var cryptographer: Cryptographer?

    /// A weak reference to the outbound queue located in the outbound node.
    weak var outboundQueue: ThreadedQueue<NodePacket>?

    /// A weak reference to the encapsulating router.
    fileprivate weak var router: Router!

    init(id: Int) {
        self.id = id
    }

    /// Overridable method that is called by the router once the handler has
    /// been initialized completely.
    ///
    /// The method may be used to disable the cryptographer by setting it to
    /// `nil` for example.
    func didCreate() { }

    /// Overridable method which defines the main body of the instance.
    ///
    /// - parameters:
    ///     - packet: The inbound packet that was sent to the handler.
    ///
    /// - returns: Optionally returns data that will be the body of a message
    ///     which will be sent back to the sender. If `nil` is returned, then
    ///     nothing will be sent back.
    ///
    /// - throws: This method may throw an exception which will be handled by
    ///     the calling `execute` method. If an exception is thrown, then an
    ///     error message will be sent back to the sender with a description
    ///     of the message.
    func main(packet: NodePacket) throws -> Data? {
        return nil
    }

    /// Overridable method which returns the message flags to use on all
    /// outbound messages from this handler.
    func getMessageFlags(isError: Bool) -> Message.Flags {
        var flags = Message.Flags()
        if isError {
            flags.set(MessageFlags.Error)
        } else {
            if cryptographer != nil {
                flags.set(MessageFlags.Encrypted)
            }
        }
        return flags
    }

}

// MARK: Final Methods

extension Handler {

    /// Marks this handler for destruction.
    ///
    /// When called, this method will mark this handler instance for deletion.
    /// If marked for destruction, the instance will be deleted one the main
    /// method has finished executing.
    final func destroy() {
        router.markHandlerForDestruction(id: id)
    }

    /// The main execution method for the handler.
    ///
    /// Should be called asynchronously by the router when an inbound message is
    /// sent to a specific handler.
    ///
    /// This method takes care of calling the `main` method as well as adding
    /// new outbound messages to the outbound queue. Errors thrown by the `main`
    /// method are handled here; an error message is sent back to the sender if
    /// such an even occurs.
    ///
    /// - parameters:
    ///     - packet: The inbound packet that was sent to this handler.
    final func execute(packet: NodePacket) {
        do {
            if let outboundData = try self.main(packet: packet) {
                let data: Data
                if let encrypter = cryptographer {
                    data = try encrypter.encrypt(outboundData)
                } else {
                    data = outboundData
                }
                let flags = self.getMessageFlags(isError: false)
                let msg = Message(data, flags: flags, id: UInt16(id))
                let outPacket = NodePacket(
                        address: packet.address,
                        message: msg,
                        time: Time.now
                )
                if let outQueue = outboundQueue {
                    outQueue.enqueue(outPacket)
                } else {
                    Log.event(
                            "Unable to resolve reference to outbound queue",
                            event: .warning
                    )
                }
            }
        } catch let error {
            let description: String
            switch error {
            case let serverError as ServerError:
                description = serverError.description
            case let networkError as NetworkError:
                description = networkError.description
            default:
                description = "An unknown error occurred."
            }
            let flags = self.getMessageFlags(isError: true)
            let msg = Message(description, flags: flags, id: UInt16(id))!
            let outPacket = NodePacket(
                    address: packet.address,
                    message: msg,
                    time: Time.now
            )
            if let outQueue = outboundQueue {
                outQueue.enqueue(outPacket)
            } else {
                Log.event(
                        "Unable to resolve reference to outbound queue",
                        event: .warning
                )
            }
        }
    }

}

// MARK: Router Extension

// Router extension defined here so that the weak router reference in the
// Handler class can be marked a fileprivate so that subclasses can't access it.

extension Router {

    /// Configures a new handler instance for this router.
    func configureHandler<HandlerType: Handler>(_ handler: inout HandlerType) {
        handler.router = self
        handler.outboundQueue = self.outboundQueue
        handler.cryptographer = self.cryptographer
        handler.didCreate()
    }

}

