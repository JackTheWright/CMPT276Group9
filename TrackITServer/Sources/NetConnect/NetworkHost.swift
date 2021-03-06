//
// File         : NetworkHost.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-27
//

import Foundation
import SwiftyJSON

public class NetworkHost {
    
    internal weak var socket: StreamingSocket?
    internal var cryptographer: Cryptographer?
    internal var address: Address
    internal var convoId: UInt16
    
    internal init(socket: StreamingSocket, address: Address, id: UInt16) {
        self.socket = socket
        self.address = address
        self.convoId = id
    }
    
    /// Sets the read and write timeout for the host.
    ///
    /// - parameters:
    ///     - seconds: The number of seconds to wait before timeout. If `nil`
    ///         then timeout is set to infinity.
    public func setTimeout(_ seconds: UInt?) {
        if let s = seconds {
            socket!.timeout = s * 1000
        } else {
            socket!.timeout = nil
        }
    }
    
}

// MARK: Send Methods

public extension NetworkHost {
    
    /// Sends data to the host.
    ///
    /// - parameters:
    ///     - data: The data to send.
    ///
    /// - throws: Throws an error if unable to send.
    func send(_ data: Data) throws {
        try send(data, flags: Message.Flags())
    }
    
    /// Sends a string to the host.
    ///
    /// - parameters:
    ///     - string: The string to send to the host.
    ///
    /// - throws: Throws `NetworkError.UnableToConvertStringToData` if unable to
    ///     convert the string. Errors thrown from `send(Data)` are also passed
    ///     through this method.
    func send(_ string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw NetworkError.UnableToConvertStringToData
        }
        try send(data)
    }
    
    /// Sends a JSON object to the host.
    ///
    /// - parameters:
    ///     - json: The JSON object to send to the host.
    ///
    /// - throws: Throws an error if unable to convert JSON to data, or if
    ///     unable to send the data.
    func send(_ json: JSON) throws {
        let data = try json.rawData()
        try send(data)
    }

    /// Sends data to the host with given message flags.
    ///
    /// - parameters:
    ///     - data: The data to send.
    ///
    ///     - flags: The flags for the message.
    ///
    /// - throws: Throws an error if unable to send.
    func send(_ data: Data, flags: Message.Flags) throws {
//        if data.count > Message.maxBodySize {
//            // If data is too big, send multiple messages recursively.
//            let cutoff = Message.maxBodySize
//            let dataToSend = data.subdata(in: 0..<cutoff)
//            let f = flags.setting(MessageFlags.MultiMessageStream)
//            try send(dataToSend, flags: f)
//            try send(data.subdata(in: cutoff..<data.count), flags: flags)
//        } else {
//            let message = Message(data, flags: flags, id: convoId)
//            try socket!.write(data: message.rawData, to: address)
//        }
        let message = Message(data, flags: flags, id: convoId)
        let d: Data
        if let crypt = cryptographer {
            d = try crypt.encrypt(message.rawData)
        } else {
            d = message.rawData
        }
        try socket!.write(data: d, to: address)
    }

    /// Sends a string to the host with given message flags.
    ///
    /// - parameters:
    ///     - string: The string to send to the host.
    ///
    ///     - flags: The flags for the message.
    ///
    /// - throws: Throws `NetworkError.UnableToConvertStringToData` if unable to
    ///     convert the string. Errors thrown from `send(Data)` are also passed
    ///     through this method.
    func send(_ string: String, flags: Message.Flags) throws {
        guard let data = string.data(using: .utf8) else {
            throw NetworkError.UnableToConvertStringToData
        }
        try send(data, flags: flags)
    }

    /// Sends a JSON object to the host.
    ///
    /// - parameters:
    ///     - json: The JSON object to send to the host.
    ///
    ///     - flags: The flags for the message.
    ///
    /// - throws: Throws an error if unable to convert JSON to data, or if
    ///     unable to send the data.
    func send(_ json: JSON, flags: Message.Flags) throws {
        let data = try json.rawData()
        try send(data, flags: flags)
    }
    
}

// MARK: Receive Methods

public extension NetworkHost {
    
    /// Receives data from the host.
    ///
    /// - returns: Returns the data received from the host.
    ///
    /// - throws: Throws an error if unable to receive data.
    func receiveData() throws -> Data {
        let inData = try socket!.read().data
        let data: Data
        if let crypt = cryptographer {
            data = try crypt.decrypt(inData)
        } else {
            data = inData
        }
        guard let message = Message(from: data) else {
            throw NetworkError.MalformedMessage
        }
        if message.flags.get(MessageFlags.MultiMessageStream) {
            return try message.body + receiveData()
        } else {
            return message.body
        }
    }
    
    /// Receives data from the host as a string.
    ///
    /// - returns: Returns the data received from the host.
    ///
    /// - throws: Throws an error if unable to receive data.
    func receiveString() throws -> String {
        let data = try receiveData()
        guard let string = String(data: data, encoding: .utf8) else {
            throw NetworkError.UnableToConvertDataToString
        }
        return string
    }
    
    /// Receives data from the host as a JSON object.
    ///
    /// - returns: Returns the data received from the host.
    ///
    /// - throws: Throws an error if unable to receive data.
    func receiveJSON() throws -> JSON {
        let data = try receiveData()
        let json = try JSON(data: data)
        return json
    }
    
}
