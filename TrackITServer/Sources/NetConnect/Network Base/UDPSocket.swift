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
    
    /// Sets the socket's write timeout to a given number of seconds.
    ///
    /// - parameters:
    ///     - seconds: The number of seconds to set the write timeout to.
    ///
    /// - returns: Returns `true` if timeout was set successfully; otherwise,
    ///     returns `false`.
    @discardableResult
    public func setWriteTimeout(_ seconds: UInt) -> Bool {
        do {
            try socket.setWriteTimeout(value: seconds * 1000)
            return true
        } catch {
            return false
        }
    }
    
    /// Sets the socket's write timeout to inifity.
    ///
    /// - returns: Returns `true` if action was successful, `false` otherwise.
    @discardableResult
    public func removeWriteTimeout() -> Bool {
        do {
            try socket.setWriteTimeout()
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
    public func read() throws -> ReadData {
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
    public func write(data: Data, to address: Address) throws -> Int {
        return try socket.write(from: data, to: address.addr)
    }
    
}

// MARK: Packet Loss Detection

fileprivate extension UDPSocket {

    /// Packets will be 512 bytes in size with an 8 byte header; meaning that
    /// the maximum body size will be 512 - 8 = 504 bytes.
    var maxPacketBodySize: Int { return 512 - 8 }


    /// Data structure which holds packet information.
    ///
    /// The packet is encoded as such:
    ///     1. id       (4 bytes)
    ///     2. count    (4 bytes)
    ///     3. data
    struct Packet {

        /// The id number for this packet.
        var id: Int32

        /// The total number of packets in this transmission.
        var count: Int32

        /// Transmission data.
        var data: Data

        /// Encodes the packet into a single data object using the 
        /// aforementioned encoding.
        func encode() -> Data {
            var d = Data()
            d.append(contentsOf: id.bytes)
            d.append(contentsOf: count.bytes)
            d.append(data)
            return d
        }

        /// Decodes a data object into a `Packet`. Returns `nil` if unable to
        /// do so.
        static func decode(from d: Data) -> Packet? {
            guard d.count >= 8 else {
                return nil
            }
            guard let _id = Int32(bytes: d.subdata(in: 0..<4)) else {
                return nil
            }
            guard let _count = Int32(bytes: d.subdata(in: 4..<8)) else {
                return nil
            }
            let  _data = d.subdata(in: 8..<d.count)
            return Packet(id: _id, count: _count, data: _data)
        }

    }


    func sendAsPackets(data: Data) throws {
        var packets = [Packet]()
        let count = data.count.dividingRoundingUp(by: maxPacketBodySize)
    }

//    func readPackets() throws -> ReadData {
//
//    }

}
