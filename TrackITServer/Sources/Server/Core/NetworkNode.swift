//
// File         : NetworkNode.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation
import Threading
import NetConnect

class NetworkNode<Delegate> where Delegate : NodeDelegate {

    var delegate = Delegate()

    /// Network socket used by the node.
    let socket: StreamingSocket

    /// Atomic flag, denoting the active state of the node.
    let active = Atomic<Bool>(false)

    /// Message buffer for this node.
    ///
    /// Depending on the delegate type, this queue may be used as an inbound
    /// buffer or an outbound buffer.
    let messageQueue = ThreadedQueue<NodePacket>()

    /// Grand Central Dispatch instruction queue for this object.
    fileprivate let dispatchQueue = DispatchQueue(
            label: LabelDispatch.getLabel()
    )

    fileprivate let dispatchGroup = DispatchGroup()

    /// Initializes the network node.
    init(socket: StreamingSocket) {
        self.socket = socket
        delegate.socket = self.socket
        delegate.active = self.active
        delegate.messageQueue = self.messageQueue
    }

    deinit {
        if (active.load()) {
            Log.verbose("Destruction of active node", event: .warning)
        }
    }

}

// MARK: Activation Methods

extension NetworkNode {

    /// Activates the node and asynchronously calls the `start` function.
    func activate() {
        active.store(true)
        dispatchGroup.enter()
        dispatchQueue.async {
            self.delegate.start()
            self.dispatchGroup.leave()
        }
    }

    /// Deactivates the node and waits for the asynchronous `start` function to
    /// finish before returning.
    func deactivate() {
        active.store(false)
//        dispatchGroup.wait()
        delegate.didEnd()
    }

}

typealias InboundNode = NetworkNode<InboundDelegate>

typealias OutboundNode = NetworkNode<OutboundDelegate>
