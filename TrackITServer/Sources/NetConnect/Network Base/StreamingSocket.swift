//
// File         : StreamingSocket.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-25
//

import Foundation
import Socket
import SwiftyJSON

public class StreamingSocket {

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
    
    public var port: Int = 60011 // default port is 60011

    public init?() {
        guard let sock = try? Socket.create(
                family: .inet,
                type: .datagram,
                proto: .udp) else { return nil }
        self.socket = sock
    }
    
    public func close() {
        socket.close()
    }

}

// MARK: StreamingSocket.Packet Type Declaration

public extension StreamingSocket {

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

    }

}

// MARK: Read & Write

public extension StreamingSocket {

    func write(data: Data, to address: Address) throws {
        defer {
            if let t = timeout {
                try? socket.setReadTimeout(value: t)
            } else {
                try? socket.setReadTimeout()
            }
        }
        let packets = splitData(data)
        for packet in packets {
            try socket.write(from: packet.encode(), to: address.addr)
        }
        for _ in 1...maxRetryAttempts {
            var response = Data()
            try socket.setReadTimeout(value: 20)
            let _ = try socket.readDatagram(into: &response)
            if let packet = Packet.decoding(from: response) {
                if let ids = parseMissingIdsPacket(packet) {
                    if (ids.count == 0) {
                        return
                    }
                    for i in ids {
                        if let p = packets.get(i) {
                            try socket.write(from: p.encode(), to: address.addr)
                        }
                    }
                } else if packet.id == -1 {
                    return
                }
            }
        }
    }

    func listen(on port: Int) throws -> (sender: Address, data: Data) {
        self.port = port
        return try recievePackets(using: initialListen)
    }
    
    func read() throws -> (sender: Address, data: Data) {
        return try recievePackets(using: initialRead)
    }

}

// MARK: Internals

fileprivate extension StreamingSocket {

    /// The max size for a packet body. The max packet size is 512 bytes with
    /// an 8 byte header. Therefore, the max body size is 512 - 8 = 504.
    var maxPacketBodySize: Int { return 504 }
    
    /// The maximum number of attempts to fill in missing packets.
    var maxRetryAttempts: Int { return 128 }

    /// Converts a `Data` object into a series of packets.
    ///
    /// - parameters:
    ///     - data: The data to convert to packets.
    ///
    /// - returns: An array of packets which contain all the information present
    ///     in the input data.
    func splitData(_ data: Data) -> [Packet] {
        let count = data.count.dividingRoundingUp(by: maxPacketBodySize)
        var packetArray = [Packet]()
        for i in 0..<count {
            let s = maxPacketBodySize * i
            let e = min(data.count, maxPacketBodySize * (i + 1))
            packetArray.append(Packet(
                    id: Int32(i),
                    count: Int32(count),
                    data: data.subdata(in: s..<e)
            ))
        }
        return packetArray
    }

    /// Converts an array of packets into a `Data` object. This is the inverse
    /// operation of `splitData`.
    ///
    /// - parameters:
    ///     packetArray: An array of optional packets which will be constructed
    ///         into a data object. Packets that are `nil` will be omitted from
    ///         the data. `packetArray` should be checked before calling this
    ///         function to esnure that there are no `nil` packets otherwise
    ///         there will be holes in the data.
    ///
    /// - returns: A data object made up of the bodies of the packets.
    func buildData(from packetArray: [Packet?]) -> Data {
        var data = Data()
        for optionalPacket in packetArray {
            if let packet = optionalPacket {
                data.append(packet.data)
            }
        }
        return data
    }

    /// Returns an array of packet ids that are not present in `packetArray`.
    ///
    /// - parameters:
    ///     - packetArray: An array of optional packets to check for missing
    ///         ids.
    ///
    /// - returns: An array of integers representing the ids of the packets that
    ///     are `nil` in `packetArray`.
    func getMissingPacketIds(from packetArray: [Packet?]) -> [Int] {
        var missingIds = [Int]()
        for i in 0..<packetArray.count {
            if packetArray[i] == nil {
                missingIds.append(i)
            }
        }
        return missingIds
    }
    
    /// Reads the rest of the inbound packets after performing the initial read
    /// action.
    ///
    /// Inbound packets that have ids that are outside the bounds of the array
    /// of packets will be dropped. This is done so that a fatal error will not
    /// occur when trying to store the packet.
    ///
    /// - parameters:
    ///     - packetArray: The array of packets that inbound packets will be
    ///         stored in.
    ///
    /// - throws: Throws an error if unable to reset the read timeout of the
    ///     socket.
    func read(into packetArray: inout [Packet?], count: Int) throws {
        try socket.setReadTimeout(value: 20)
        for _ in 0..<count {
            var data = Data()
            do {
                let x = try socket.readDatagram(into: &data)
                if (x.bytesRead == 0) {
                    break
                }
                if let packet = Packet.decoding(from: data) {
                    packetArray.set(packet.id, to: packet)
                }
            } catch {
                break
            }
        }
        if let t = timeout {
            try socket.setReadTimeout(value: t)
        } else {
            try socket.setReadTimeout()
        }
    }
    
    /// Converts an array of missing packet ids into a sendable packet.
    ///
    /// Format is a set of comma separated integers.
    ///
    /// - parameters:
    ///     - missingPackets: An array of missing packet ids.
    ///
    /// - returns: A sendable packet containing the missing packet ids.
    ///
    /// - throws: Throws an error if unable to convert the array into a `Data`
    ///     object.
    func createResponsePacket(_ missingPackets: [Int]) throws -> Packet {
        var str = ""
        for i in missingPackets {
            str += "\(i),"
        }
        guard let data = str.data(using: .utf8) else {
            throw NetworkError.SocketWriteError("error: create response packet")
        }
        let packet = Packet(id: 0, count: 1, data: data)
        return packet
    }
    
    /// Converts a missing id response packet into an array of missing ids.
    ///
    /// - parameters:
    ///     - packet: A packet containing the missing id information.
    ///
    /// - returns: An array of missing packet ids or `nil` if unable to convert.
    func parseMissingIdsPacket(_ packet: Packet) -> [Int]? {
        guard let str = String(data: packet.data, encoding: .utf8) else {
            return nil
        }
        var array = [Int]()
        var strBuilder = ""
        for c in str {
            if c == "," {
                guard let i = Int(strBuilder) else {
                    return nil
                }
                array.append(i)
                strBuilder = ""
            } else {
                strBuilder.append(c)
            }
        }
        return array
    }
    
    /// Performs the initial reading of an inbound packet.
    ///
    /// - returns: Returns the initial packet allong with an address for the
    ///     sender.
    ///
    /// - throws: Throws an error in unable to recieve an inbound packet or the
    ///     packet was in an invalid format.
    func initialRead() throws -> (Packet, Address) {
        var data = Data()
        let readData = try socket.readDatagram(into: &data)
        guard let packet = Packet.decoding(from: data) else {
            throw NetworkError.MalformedMessage
        }
        guard let addr = readData.address else {
            throw NetworkError.Timeout
        }
        return (packet, Address(addr))
    }
    
    /// Performs the initial listening for inbound packets.
    ///
    /// - returns: Returns the initial packet allong with an address for the
    ///     sender.
    ///
    /// - throws: Throws an error in unable to recieve an inbound packet or the
    ///     packet was in an invalid format.
    func initialListen() throws -> (Packet, Address) {
        var data = Data()
        let readData = try socket.listen(forMessage: &data, on: port)
        guard let packet = Packet.decoding(from: data) else {
            throw NetworkError.MalformedMessage
        }
        guard let addr = readData.address else {
            throw NetworkError.Timeout
        }
        return (packet, Address(addr))
    }
    
    /// Performs the core read / listen action. Waits for an initial packet,
    /// then attempts to read the rest of the packets, sending back a list
    /// of missed packets to the sender then waiting again for the remaining
    /// packets.
    ///
    /// - parameters:
    ///     - initialAction: The initial action to take, either read or listen.
    ///
    /// - returns: The entirity of the data that was transmitted.
    ///
    /// - throws: Throws an error if something went wrong or not all of the
    ///     packets were recieved after a given number of attempts.
    func recievePackets(using initialAction: () throws -> (Packet, Address))
    throws -> (Address, Data)
    {
        let initialData = try initialAction()
        let packet = initialData.0
        var packetArray = [Packet?](repeating: nil, count: Int(packet.count))
        packetArray.set(packet.id, to: packet)
        for _ in 1...maxRetryAttempts {
            try read(into: &packetArray, count: Int(packet.count))
            let missingPackets = getMissingPacketIds(from: packetArray)
            if missingPackets.count != 0 {
                let response = try createResponsePacket(missingPackets)
                let responseData = response.encode()
                try socket.write(from: responseData, to: initialData.1.addr)
            } else {
                let doneStatement = "done".data(using: .utf8)!
                let donePacket = Packet(id: -1, count: -1, data: doneStatement)
                try socket.write(
                    from: donePacket.encode(),
                    to: initialData.1.addr
                )
                break
            }
        }
        if getMissingPacketIds(from: packetArray).count == 0 {
            return (initialData.1, buildData(from: packetArray))
        } else {
            throw NetworkError.Timeout
        }
    }

}
