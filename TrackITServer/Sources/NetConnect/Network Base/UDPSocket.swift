//
// File         : UDPSocket.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-26
//

import Foundation
import Socket

public class UDPSocket {
    
    /// Contains data about a udp transmission.
    public typealias ReadData = (address: Address, bytesRead: Int, data: Data)
    
    private var socket: Socket
    
    /// The port that this socket is connected to. `nil` if the socket has not
    /// been connected to any port.
    public private(set) var port: Int?
    
    /// Constructs a default udp socket.
    ///
    /// - throws: Throws `Socket.Error` if unable to create the underlying
    ///     socket, or if unable to set `udpBroadcast`.
    public init() throws {
        self.socket = try Socket.create(
            family: .inet,
            type: .datagram,
            proto: .udp)
        try socket.udpBroadcast(enable: true)
    }
    
    /// Closes the socket.
    deinit {
        self.socket.close()
    }
    
    /// Sets the socket's read timeout to a given number of seconds.
    ///
    /// - parameters:
    ///     - seconds: The number of seconds to set the read timeout to.
    ///
    /// - returns: Returns `true` if timeout was set successfully; otherwise,
    ///     returns `false`.
    @discardableResult
    public func setReadTimeout(_ seconds: UInt) -> Bool {
        do {
            try socket.setReadTimeout(value: seconds * 1000)
            return true
        } catch {
            return false
        }
    }
    
    /// Sets the socket's read timeout to inifity.
    ///
    /// - returns: Returns `true` if action was successful, `false` otherwise.
    @discardableResult
    public func removeReadTimeout() -> Bool {
        do {
            try socket.setReadTimeout()
            return true
        } catch {
            return false
        }
    }
    
    /// Listens of a given port for an incoming message.
    ///
    /// - parameters:
    ///     - port: The port to listen on. Must be between 0 and `UInt16.max`.
    ///
    /// - returns: Returns a tuple containing the message recieved along with
    ///     the number of bytes read and an `Address` object for the connected
    ///     host.
    ///
    /// - throws: Throws `NetworkError.Timeout` if the connection times out, or
    ///     `Socket.Error` if there is an underlying socket error.
    public func listen(on port: Int) throws -> ReadData {
        self.port = port
        var data = Data()
        let result = try socket.listen(forMessage: &data, on: port)
        if let addr = result.address {
            return (Address(addr), result.bytesRead, data)
        } else {
            throw NetworkError.Timeout
        }
    }
    
    /// Reads from the socket.
    ///
    /// - returns: Returns a tuple containing the message recieved along with
    ///     the number of bytes read and an `Address` object for the connected
    ///     host.
    ///
    /// - throws: Throws `NetworkError.Timeout` if the connection times out, or
    ///     `Socket.Error` if there is an underlying socket error.
    ///
    /// `read` is different from `listen` in that `read` assumes that the socket
    /// is already set up on a specific port. One should call `listen` first
    /// to wait for an initial message, the use `read` to continue accepting
    /// messages on the same port.
    func read() throws -> ReadData {
        var data = Data()
        let result = try socket.readDatagram(into: &data)
        if let addr = result.address {
            return (Address(addr), result.bytesRead, data)
        } else {
            throw NetworkError.Timeout
        }
    }
    
    /// Sends data to a given address.
    ///
    /// - returns: Returns the number of bytes written.
    ///
    /// - throws: Throws `Socket.Error` if unable to write.
    @discardableResult
    func write(data: Data, to address: Address) throws -> Int {
        return try socket.write(from: data, to: address.addr)
    }
    
}
