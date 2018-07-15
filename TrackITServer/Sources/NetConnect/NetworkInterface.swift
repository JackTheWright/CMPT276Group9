//
// File         : NetworkInterface.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-30
//

import Foundation
import SwiftyJSON

open class NetworkInterface {
    
    /// Type definition for a conversation closure.
    public typealias ConvoClosure = (NetworkHost) throws -> Void
    
    private var socket: UDPSocket
    
    /// The network interface's encryption delegate.
    ///
    /// If not supplied, then none of the network transmissions from this
    /// interface will be encrypted.
    public var cryptographer: Cryptographer?
    
    /// Initializes this instance.
    ///
    /// Returns `nil` if unable to create the internal socket.
    public init?() {
        if let s = try? UDPSocket() {
            self.socket = s
        } else {
            return nil
        }
    }
    
    /// Initializes from a cryptographer delegate.
    ///
    /// Returns `nil` if unable to create the internal socket.
    public init?(cryptographer: Cryptographer) {
        if let s = try? UDPSocket() {
            self.socket = s
            self.cryptographer = cryptographer
        } else {
            return nil
        }
    }
    
    /// Initiates a connection to a remote host.
    ///
    /// Use this method to connect to a host that is activly waiting for a
    /// connection. The local machine will be the instigator of the connection.
    ///
    /// Before the `convo` closure is called, a series of messages will be sent
    /// and received from the host to set up.
    ///
    /// - parameters:
    ///     - host: The IPv4 address or fully qualified domain name of the host
    ///         to connect to.
    ///
    ///     - convo: An escaping closure that defines the actions to take once
    ///         a connection is established.
    public func connect (to host: String,
                         on port: Int,
                         _ convo: @escaping ConvoClosure)
    {
        do {
            // Create host address
            guard let address = Address(hostname: host, port: port) else {
                throw NetworkError.UnableToConnectToHost(host: host)
            }
            
            // Send handshake request
            let hrbody = createHandshakeRequest()
            let handshake = Message.handshakeRequest(hrbody)
            try socket.write(data: handshake.rawData, to: address)
            let response = try socket.read()
            guard let hrResponse = Message(from: response.data) else {
                throw NetworkError.MalformedMessage
            }
            
            // Check if request was validated
            if hrResponse.flags.get(MessageFlags.HSDeny) {
                guard let reason = hrResponse.string else {
                    throw NetworkError.UnableToConvertDataToString
                }
                throw NetworkErrorEvent.RejectConnection(reason: reason)
            }
            
            // HSRequest has been confirmed; start conversation
            try didStartConnection(message: hrResponse)
            let cid = UInt16(hrResponse.id)
            let host = NetworkHost(socket: socket, address: address, id: cid)
            host.cryptographer = cryptographer
            try convo(host)
            
            // Conversation finished
            try didConvoEnd(host: host)
            didCloseConvo(id: cid)
        } catch let e {
            didThrowError(error: e)
        }
    }
    
    /// Waits for a connection to be established with the local host.
    ///
    /// Use this method to receive connections from other hosts. This method
    /// will wait until a connection is received and then proceed to establish
    /// a conversation with the requesting host.
    ///
    /// - parameters:
    ///     - port: The port to listen on.
    ///
    ///     - convo: An escaping closure that defines the actions to take once
    ///         a connection is established.
    public func listen(on port: Int, _ convo: @escaping ConvoClosure) {
        do {
            // Wait for handshake request
            let request = try socket.listen(on: port)
            let address = request.address
            guard let hrRequest = Message(from: request.data) else {
                throw NetworkError.MalformedMessage
            }
            
            // Verify the connection request.
            do {
                try didStartConnection(message: hrRequest)
            } catch let NetworkErrorEvent.RejectConnection(reason) {
                let rejectionMessage = Message.handshakeResponse(
                    valid: false,
                    body: reason.data(using: .utf8) ?? Data(),
                    id: 0
                )
                try socket.write(data: rejectionMessage.rawData, to: address)
                throw NetworkErrorEvent.RejectConnection(reason: reason)
            }
            
            // HSRequest validated; send back confirmation
            let cid = try generateCovoId()
            let confirmationMessage = Message.handshakeResponse(
                valid: true,
                body: Data(),
                id: cid
            )
            try socket.write(data: confirmationMessage.rawData, to: address)
            
            // Start conversation
            let host = NetworkHost(socket: socket, address: address, id: cid)
            host.cryptographer = cryptographer
            try convo(host)
            
            // Conversation finished
            try didConvoEnd(host: host)
            didCloseConvo(id: cid)
        } catch let e {
            didThrowError(error: e)
        }
    }
    
}

// MARK: Overridable Event Handlers

extension NetworkInterface {
    
    /// Called to create the body of the handshake request.
    ///
    /// May be overrided to provide specific data that the receiver will be
    /// looking for when receiving a handshake request.
    ///
    /// The default body is a JOSN object that contains the ip address of the
    /// sender.
    ///
    /// - important: The handshake request message is **NOT** encrypted, do not
    ///     send any personal information in the handshake request message.
    ///
    /// - returns: Returns a `Data` object that will make up the body of the
    ///     handshake request.
    open func createHandshakeRequest() -> Data {
        let jsonData: [String : Any] = [
            "ifaddr" : IFAddress.localIP() ?? ""
        ]
        let json = JSON(jsonData)
        return try! json.rawData()
    }
    
    /// Called when a connection is established.
    ///
    /// # Network Interface Event Handler
    ///
    /// *Override to provide functionality*
    ///
    /// ------------------------------------------------------------------------
    ///
    /// Called after connection has been established with the host but before
    /// the conversation closure has been called.
    ///
    /// If the interface is an instigator this event will trigger with the relpy
    /// from the host after the initial request is sent. In this case, the event
    /// will be triggered as soon as the reply is received. If a rejection
    /// message was sent as the reply this event will still trigger, but this
    /// event is not responsable for terminating the connection; that will
    /// happen immediately after this event finishes.
    ///
    /// If this interface is not the instigator, then this event will be called
    /// as soon as a connection request is received.
    ///
    /// Use this handler to perform validation checking on the host if needed.
    /// Any exceptions thrown from this handler will abort the connection. This
    /// event should be used to verify that a connection with the host should
    /// proceed or not. If the connection should be rejected, then an exception
    /// should be thrown from this event. If no exceptions are thrown, then the
    /// connection will proceed.
    ///
    /// ------------------------------------------------------------------------
    ///
    /// ## Example:
    /// Possible implementation for a server to ensure that connections have a
    /// valid verification code that should be sent with the connection request.
    ///
    ///     override func didStartConnection(message: Message) throws {
    ///         let verificationCode = message.body(as: String.Type)
    ///         guard verificationCode == validCode else {
    ///             throw NetworkErrorEvent.RejectConnection(
    ///                 reason: "Invalid verification code."
    ///             )
    ///         }
    ///     }
    ///
    /// - parameters:
    ///     - message: The initial connection request message sent from the
    ///         host.
    ///
    /// - throws: Throws an exception if the the connection should not proceed.
    open func didStartConnection(message: Message) throws { }
    
    /// Called after the conversation closure was successully called and before
    /// connection teardown starts.
    ///
    /// # Network Interface Event Handler
    ///
    /// *Override to provide functionality*
    ///
    /// ------------------------------------------------------------------------
    ///
    /// This event is triggered after the conversaiton closure has finished
    /// without throwing any errors, but before the final connection teardown
    /// starts. This event may be used to send any final messages to the host
    /// that were not suitable to put in the closure or to retrieve some info
    /// from the host about the connection.
    ///
    /// If this event throws an error, the connection will be aborted and sent
    /// into a hard shutdown.
    ///
    /// ------------------------------------------------------------------------
    ///
    /// - parameters:
    ///     - host: The host that the interface is connected to.
    ///
    /// - throws: Throws an exception if something went wrong and the connection
    ///     should perform a hard shutdown instead of the usual soft shutdown.
    open func didConvoEnd(host: NetworkHost) throws { }
    
    /// Called after final shutdown messages have been recieved.
    ///
    /// # Network Interface Event Handler
    ///
    /// *Override to provide functionality*
    ///
    /// ------------------------------------------------------------------------
    ///
    /// This event should be used to teardown any external structures that were
    /// supporting the conversation. For example, this even may be used to
    /// notify the connection broker that a conversation with a given id has
    /// finished in a system that handle multiple conversations.
    ///
    /// ------------------------------------------------------------------------
    ///
    /// - parameters:
    ///     - id: The id of the conversation that just ended.
    open func didCloseConvo(id: UInt16) { }
    
    /// Called if an exception is thrown during any part of the connection.
    ///
    /// # Network Interface Event Handler
    ///
    /// *Override to provide functionality*
    ///
    /// ------------------------------------------------------------------------
    ///
    /// Should **NOT** be used to teardown the connection (closing sockets etc.)
    /// as that is performed internally.
    ///
    /// May be used to log error messages or to notify other external systems
    /// that the connection encountered an error.
    ///
    /// ------------------------------------------------------------------------
    ///
    /// - parameters:
    ///     - error: The error that was thrown by the connection.
    open func didThrowError(error: Error) {
        if let neterr = error as? NetworkError {
            print(neterr.description)
        } else if let netevent = error as? NetworkErrorEvent {
            print(netevent.message)
        } else {
            print(error.localizedDescription)
        }
    }
    
    /// Called by a listener interface to generate a conversation id for a new
    /// conversation that is just about to begin.
    ///
    /// Should only be overriden by a network interface that will be handling
    /// multiple conversations at the same time.
    open func generateCovoId() throws -> UInt16 {
        return 0
    }
    
}
