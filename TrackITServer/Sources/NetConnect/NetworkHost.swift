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
    internal var address: Address
    internal var convoId: UInt16
    
    internal init(socket: UDPSocket, address: Address, id: UInt16) {
        self.socket = socket
        self.address = address
        self.convoId = id
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
        // FIXME: Implement better sending
        if let s = socket {
            try s.write(data: data, to: address)
        } else {
            throw NetworkError.SocketWriteError("Unable to unwrap socket")
        }
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
        // FIXME: Implement better receiving
        if let s = socket {
            let data = try s.read().data
            return data
        } else {
            throw NetworkError.SocketReadError("Unable to unwrap socket")
        }
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
