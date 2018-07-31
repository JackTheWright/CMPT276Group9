//
// File         : UDPSocket.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-26
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-22
//
//  Restructured class to allow for packet drop detection and correction.
//

import Foundation
import Socket

@available(*, deprecated, message: "Use StreamingSocket instead")
public class UDPSocket {

    public typealias ReadData = (address: Address, bytesRead: Int, data: Data)

    private var socket: Socket

    /// The current timeout setting for the socket. Measured in milliseconds.
    public var timeout: UInt? {
        didSet {
            if let milliseconds = timeout {
                try? socket.setWriteTimeout(value: milliseconds)
                try? socket.setReadTimeout(value: milliseconds)
            } else {
                try? socket.setWriteTimeout()
                try? socket.setReadTimeout()
            }
        }
    }

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
        self.timeout = nil
    }

    /// Closes the socket.
    deinit {
        self.socket.close()
    }

}

// MARK: Read & Write Methods

@available(*, deprecated, message: "Use StreamingSocket instead")
public extension UDPSocket {

    func write(data: Data, to address: Address) throws {
        var packets = [Packet]()
        let count = data.count.dividingRoundingUp(by: maxPacketBodySize)
        for i in 0..<count {
            let s = i * maxPacketBodySize
            let e = (i + 1) * maxPacketBodySize
            let packet = Packet(
                    id: Int32(i),
                    count: Int32(count),
                    data: data.subdata(in: s..<(min(e, data.count)))
            )
            packets.append(packet)
        }
        try write(packets: packets, to: address)
    }

//    func read() throws -> ReadData {
//        var initialData = Data()
//        let readData = try socket.readDatagram(into: &initialData)
//        if let packet = Packet.decoding(from: initialData) {
//            guard packet.count >= 0 && packet.id >= 0 else {
//                throw NetworkError.MalformedMessage
//            }
//            guard packet.id < packet.count else {
//                throw NetworkError.MalformedMessage
//            }
//            var packetArray = [Packet?](repeating: nil, count: Int(packet.count))
//            packetArray[Int(packet.id)] = packet
//            readPackets(into: &packetArray)
//
//            var i = 0
//            while let missingPackets = getMissingPackets(from: packetArray),
//                  i < packet.count
//            {
//                readPackets(into: &packetArray)
//                i += 1
//            }
//
//        } else {
//            return (Address(readData.address!), readData.bytesRead, initialData)
//        }
//    }

    func read() throws -> ReadData {
        throw NetworkError.SocketReadError("Not Implemented")
    }

    func listen(on port: Int) throws -> ReadData {
        var initialData = Data()
        let readData = try socket.listen(forMessage: &initialData, on: port)
        print("captured connection")
        if let packet = Packet.decoding(from: initialData) {
            guard packet.count >= 0 && packet.id >= 0 else {
                throw NetworkError.MalformedMessage
            }
            guard packet.id < packet.count else {
                throw NetworkError.MalformedMessage
            }
            var packetArray = [Packet?](repeating: nil, count: Int(packet.count))
            packetArray[Int(packet.id)] = packet
            print("reading packets")
            readPackets(into: &packetArray)

            print("Number of missing packets =", packetArray.count(where: {
                $0 == nil
            }))

            return (Address(readData.address!), 0, Data())

//            var i = 0
//            while let missingPackets = getMissingPackets(from: packetArray),
//                  i < packet.count
//            {
//                readPackets(into: &packetArray)
//                i += 1
//            }

        } else {
            return (Address(readData.address!), readData.bytesRead, initialData)
        }
    }

}


// MARK: Internals
@available(*, deprecated, message: "Use StreamingSocket instead")
fileprivate extension UDPSocket {

    /// The read timeout to set when reading a packet stream.
    var packetReadTimeout: Int { return 100 }

    /// Max packet size is 512 bytes, therefor the max packet body size is 512
    /// minus the 8 bytes header which is 504 bytes.
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
        static func decoding(from d: Data) -> Packet? {
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

    } // struct Packet

    /// Writes an array of packets to a given address.
    ///
    /// - parameters:
    ///     - packets: An array of packets to be written to the socket. There
    ///         must be no gaps in packet ids (i.e. if there are 10 packets the
    ///         each packet must have a unique id in the range 0..<10).
    ///
    ///     - address: The address of the host to write the packets to.
    ///
    /// - throws: Throws an error if unable to write a packet.
    func write(packets: [Packet], to address: Address) throws {
        print("writting \(packets.count) packets")
        for packet in packets {
            try socket.write(from: packet.encode(), to: address.addr)
        }
    }

    /// Reads packets from the socket into an inout packet array.
    ///
    /// - parameters:
    ///     - packetArray: A mutable array to which the inbound packets will be
    ///         stored in. The array should be pre-initialized to contain the
    ///         expected number of packets.
    ///
    /// The method will stop listening for new packets once the socket throws a
    /// timeout error.
    func readPackets(into packetArray: inout [Packet?]) {
        var data = Data()
        try! socket.setReadTimeout(value: 10)
        try! socket.setWriteTimeout(value: 10)
        while let _ = try? socket.readDatagram(into: &data) {
            if let packet = Packet.decoding(from: data) {
                if packet.id >= 0 && packet.id < packetArray.count {
                    print("read packet \(packet.id)")
                    packetArray[Int(packet.id)] = packet
                }
            }
        }
    }

    /// Returns an array of missing packet ids from a given packet array. If no
    /// packets are missing, returns `nil`.
    ///
    /// - parameters:
    ///     - packetArray: The array of packets to analyze.
    ///
    /// - returns: Returns an array of missing packet ids or `nil` if none are
    ///     missing.
    ///
    /// - complexity: _O(n)_
    func getMissingPackets(from packetArray: [Packet?]) -> [Int]? {
        var missingIds = [Int]()
        for i in 0..<packetArray.count {
            if packetArray[i] == nil {
                missingIds.append(i)
            }
        }
        return missingIds.count == 0 ? nil : missingIds
    }

}

// MARK: Legacy Methods
@available(*, deprecated, message: "Use StreamingSocket instead")
public extension UDPSocket {

    /// Sets the socket's read timeout to a given number of seconds.
    ///
    /// - parameters:
    ///     - seconds: The number of seconds to set the read timeout to.
    ///
    /// - returns: Returns `true` if timeout was set successfully; otherwise,
    ///     returns `false`.
    @available(*, deprecated, message: "Use UDPSocket.timeout instead")
    @discardableResult
    public func setReadTimeout(_ seconds: UInt) -> Bool {
        timeout = seconds * 1000
        return true
    }

    /// Sets the socket's read timeout to infinity.
    ///
    /// - returns: Returns `true` if action was successful, `false` otherwise.
    @available(*, deprecated, message: "Use UDPSocket.timeout instead")
    @discardableResult
    public func removeReadTimeout() -> Bool {
        timeout = nil
        return true
    }

    /// Sets the socket's write timeout to a given number of seconds.
    ///
    /// - parameters:
    ///     - seconds: The number of seconds to set the write timeout to.
    ///
    /// - returns: Returns `true` if timeout was set successfully; otherwise,
    ///     returns `false`.
    @available(*, deprecated, message: "Use UDPSocket.timeout instead")
    @discardableResult
    public func setWriteTimeout(_ seconds: UInt) -> Bool {
        timeout = seconds * 1000
        return true
    }

    /// Sets the socket's write timeout to infinity.
    ///
    /// - returns: Returns `true` if action was successful, `false` otherwise.
    @available(*, deprecated, message: "Use UDPSocket.timeout instead")
    @discardableResult
    public func removeWriteTimeout() -> Bool {
        timeout = nil
        return true
    }

}
