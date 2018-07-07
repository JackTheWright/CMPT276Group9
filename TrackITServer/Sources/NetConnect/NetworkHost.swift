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
    
    internal weak var socket: UDPSocket?
    internal var cryptographer: Cryptographer?
    internal var address: Address
    internal var convoId: UInt16
    
    internal init(socket: UDPSocket, address: Address, id: UInt16) {
        self.socket = socket
        self.address = address
        self.convoId = id
    }
    
}

// Foundation Methods

fileprivate extension NetworkHost {
    
    /// Writes data to the host and ensures that it was reveived and not
    /// corrupted.
    ///
    /// - parameters:
    ///     - data: The data to write.
    ///
    /// - throws: Throws an error if unable to write data.
    func write(data: Data) throws {
        var flags = Message.Flags()
        let message: Message
        
        // Encrypt data if a cryptographer delegate is present.
        if let encrypter = cryptographer {
            let encryptedData = try encrypter.encrypt(data)
            flags.set(MessageFlags.Encrypted)
            message = Message(encryptedData, flags: flags, id: convoId)
        } else {
            message = Message(data, flags: flags, id: convoId)
        }
        
        var shouldResendMessage = true
        repeat {
            try socket!.write(data: message.rawData, to: address)
            if let response = Message(from: try socket!.read().data) {
                if response.flags.get(MessageFlags.Confirmation) {
                    print("Confirmation received")
                    shouldResendMessage = false
                } else {
                    print("Message received but did not contain confirmation")
                }
            } else {
                throw NetworkError.MalformedMessage
            }
        } while shouldResendMessage
    }
    
    /// Reads data from the host ensuring that the data was not corrupted.
    ///
    /// If received data is malformed, a resend request is sent back to the
    /// host to resend the previous data.
    ///
    /// - returns: Returns the data from the host.
    func read() throws -> Data {
        repeat {
            let msgData = try socket!.read()
            if let message = Message(from: msgData.data) {
                if message.size == msgData.bytesRead {
                    var flags = Message.Flags()
                    flags.set(MessageFlags.Confirmation)
                    let confirm = Message(Data(), flags: flags, id: convoId)
                    try socket!.write(data: confirm.rawData, to: address)
                    return message.body
                }
            }
            
            // If here is reached, then the data is corrupted and should be
            // resent
            var flags = Message.Flags()
            flags.set(MessageFlags.ResendRequest)
            let resendRequest = Message(Data(), flags: flags, id: convoId)
            try socket!.write(data: resendRequest.rawData, to: address)
        } while true
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
//        try write(data: data)
        let message = Message(data, flags: Message.Flags(), id: convoId)
        try socket!.write(data: message.rawData, to: address)
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
    
}

// MARK: Receive Methods

public extension NetworkHost {
    
    /// Reveives data from the host.
    ///
    /// - returns: Returns the data reveived from the host.
    ///
    /// - throws: Throws an error if unable to reveive data.
    func receiveData() throws -> Data {
//        return try read()
        guard let message = Message(from: try socket!.read().data) else {
            throw NetworkError.MalformedMessage
        }
        return message.body
    }
    
    /// Reveives data from the host as a string.
    ///
    /// - returns: Returns the data reveived from the host.
    ///
    /// - throws: Throws an error if unable to reveive data.
    func receiveString() throws -> String {
        let data = try receiveData()
        guard let string = String(data: data, encoding: .utf8) else {
            throw NetworkError.UnableToConvertDataToString
        }
        return string
    }
    
    /// Reveives data from the host as a JSON object.
    ///
    /// - returns: Returns the data reveived from the host.
    ///
    /// - throws: Throws an error if unable to reveive data.
    func receiveJSON() throws -> JSON {
        let data = try receiveData()
        let json = try JSON(data: data)
        return json
    }
    
}
