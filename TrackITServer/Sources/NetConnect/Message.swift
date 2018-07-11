//
// File         : Message.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-29
//

import Foundation
import SwiftyJSON

public class Message {
    
    public typealias Flags = FlagComplex<MessageFlags>

    public typealias ID = UInt16
    
    fileprivate var encodedData = Data()

    /// The conversation identifier used for handshake request messages.
    public static var handshakeId : ID {
        return 0x8000
    }
    
    /// Constructs from an encoded message.
    ///
    /// - parameters:
    ///     - data: Encoded message data.
    ///
    /// Returns `nil` if data is in an invalid format.
    public init?(from data: Data) {
        guard data.count >= 8 else { return nil }
        self.encodedData = data
        guard size == encodedData.count else { return nil }
    }
    
    /// Constructs from a body, flags, and conversation identifier. The size
    /// property of the message will be automatcally computed.
    ///
    /// - parameters:
    ///     - body: The body of the message as raw data.
    ///
    ///     - flags: A flag complex containing state flags for the message.
    ///
    ///     - id: The conversation identifier for the message.
    public init(_ body: Data, flags: Flags, id: ID) {
        encodedData = encode(body: body, flags: flags, id: id)
    }
    
    /// Constructs with a string body.
    ///
    /// - parameters:
    ///     - body: The body of the message as a `String`.
    ///
    ///     - flags: A flag complex containing state flags for the message.
    ///
    ///     - id: The conversation identifier for the message.
    ///
    /// Returns `nil` if unable to convert the string body into a `Data` object.
    public convenience init?(_ body: String, flags: Flags, id: ID) {
        guard let data = body.data(using: .utf8) else {
            return nil
        }
        self.init(data, flags: flags, id: id)
    }
    
    /// Constructs with a JSON body.
    ///
    /// - parameters:
    ///     - body: The body of the message as a `String`.
    ///
    ///     - flags: A flag complex containing state flags for the message.
    ///
    ///     - id: The conversation identifier for the message.
    ///
    /// Returns `nil` if unable to convert the JSON body into a `Data` object.
    public convenience init?(_ body: JSON, flags: Flags, id: ID) {
        guard let data = try? body.rawData() else {
            return nil
        }
        self.init(data, flags: flags, id: id)
    }
    
}

// MARK: Computed Parameters

public extension Message {
    
    /// Returns the contents of the message, metadata and all, as raw bytes.
    var rawData: Data {
        return encodedData
    }
    
    /// Returns the encoded size of the message.
    var size: Int {
        let sizeData = encodedData.subdata(in: 0..<4)
        let value: UInt32 = copyInteger(from: sizeData)
        return Int(value)
    }
    
    /// Return the conversation identifier of the message.
    var id: ID {
        let idData = encodedData.subdata(in: 4..<6)
        let value: ID = copyInteger(from: idData)
        return value
    }
    
    /// Returns the flags for the message.
    var flags: Flags {
        let flagsData = encodedData.subdata(in: 6..<8)
        let value: UInt16 = copyInteger(from: flagsData)
        return Flags(rawValue: value)
    }
    
    /// Returns the body section of the encoded data.
    var body: Data {
        return encodedData.subdata(in: 8..<encodedData.count)
    }
    
    /// Returns the body of the message as a string using UTF-8 encoding.
    /// Result is `nil` if the message body cannot be converted into a UTF-8
    /// string.
    var string: String? {
        return String(data: body, encoding: .utf8)
    }
    
    /// Returns the body of the message as a JSON object. Result is `nil` if
    /// unable to convert the body to JSON.
    var json: JSON? {
        return try? JSON(data: body)
    }
    
}

// MARK: Helper Methods

fileprivate extension Message {
    
    /// Converts `data` into a single integer of a given type.
    ///
    /// - parameters:
    ///     - data: The data to convert to an integer.
    func copyInteger<I: FixedWidthInteger>(from data: Data) -> I {
        let pointer = UnsafeMutablePointer<I>.allocate(capacity: 1)
        let stride = MemoryLayout<I>.stride
        pointer.withMemoryRebound(to: UInt8.self, capacity: stride) { ptr in
            data.copyBytes(to: ptr, count: stride)
        }
        let x = pointer.pointee
        pointer.deallocate()
        return x
    }
    
    /// Encodes the message body along with some meta data into a single data
    /// package.
    ///
    /// Data is formated like so:
    ///
    /// 1. Message Size (bytes) : UInt32
    /// 2. Conversation Id      : UInt16
    /// 3. Message Flags        : UInt16
    /// 4. Message Body         : Data
    ///
    /// The metadata is contain in the first 8 bytes of the message. Note that
    /// the size property is implicitly defined based on the other properties.
    ///
    /// - parameters:
    ///     - body: The body of the message as `Data`.
    ///
    ///     - flags: A `FlagComplex` which defines flags for the message.
    ///
    ///     - id: A 16-bit integer that denotes the id of the conversation that
    ///         this message belongs to.
    func encode(body: Data, flags: Flags, id: ID) -> Data {
        var size = UInt32(body.count + 8)
        var idData = id
        var flagData = flags.rawValue
        var data = Data()
        data.append(UnsafeBufferPointer<UInt32>(start: &size, count: 1))
        data.append(UnsafeBufferPointer<UInt16>(start: &idData, count: 1))
        data.append(UnsafeBufferPointer<UInt16>(start: &flagData, count: 1))
        data.append(body)
        return data
    }
    
}

// MARK: Static Methods

internal extension Message {
    
    /// Returns a `Message` object that is preformatted for a handshake request.
    ///
    /// - parameters:
    ///     - body: The body of the message as raw data.
    ///
    /// - returns: Returns a handshake request message.
    static func handshakeRequest(_ body: Data) -> Message {
        var flags = Flags()
        flags.set(MessageFlags.Handshake)
        return Message(body, flags: flags, id: handshakeId)
    }
    
    /// Returns a `Message` object preformatted as a response to a handshake
    /// request.
    ///
    /// - parameters:
    ///     - valid: Whether or not the handshake request was accepted.
    ///
    ///     - id: The new conversation id for the conversation. Will only be
    ///         used if `valid` is `true`.
    ///
    /// - returns: Returns a handshake response message.
    static func handshakeResponse
        (valid: Bool, body: Data, id: ID) -> Message
    {
        var flags = Flags()
        if valid {
            flags.set(MessageFlags.HSConfirm)
        } else {
            flags.set(MessageFlags.HSDeny)
        }
        return Message(body, flags: flags, id: id)
    }
    
}
