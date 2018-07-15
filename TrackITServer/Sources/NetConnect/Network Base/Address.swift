//
// File         : Address.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-26
//

import Foundation
import Socket

/// Wrapper class for Socket.Address.
public class Address {
    
    var addr: Socket.Address
    
    let hostname: String?
    
    /// Constructs an address for a given host on a specific port.
    ///
    /// - parameters:
    ///     - hostname: IPv4 address or fully qualified domain name for the
    ///         desired host.
    ///
    ///     - port: The port to connect on. Must be within the range 0 to 65535.
    ///
    /// Returns `nil` if unable to create the underlying `Socket.Address`
    /// object.
    init?(hostname: String, port: Int) {
        self.hostname = hostname
        if port < 0 || port > UInt16.max { return nil }
        if let a = Socket.createAddress(for: hostname, on: Int32(port)) {
            self.addr = a
        } else {
            return nil
        }
    }
    
    /// Constructs an address from an existing `Socket.Address` object.
    ///
    /// - parameters:
    ///     - addr: An existing `Socket.Address` object to wrap around.
    init(_ addr: Socket.Address) {
        self.addr = addr
        self.hostname = nil
    }
    
}

public extension Address {

    /// Public address creation function.
    ///
    /// Equivalent to the main `Address` initializer.
    static func create(hostname: String, port: Int) -> Address? {
        return Address(hostname: hostname, port: port)
    }

}
