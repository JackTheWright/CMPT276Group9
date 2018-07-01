//
// File         : Cryptographer.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-30
//

import Foundation

/// Protocol for network transmission encryption delegates.
public protocol Cryptographer {
    
    /// Returns an ecrypted version of the input data.
    ///
    /// - invariant:
    ///     Decrypting encrypted data must always result in the onriginal data.
    ///
    ///         let data = Data(...)
    ///         data == decrypt(encrypt(data))
    ///
    /// - throws: Throws an error if unable to encrypt the input data.
    func encrypt(_ data: Data) throws -> Data
    
    /// Returns a decrypted version of the input data.
    ///
    /// - invariant:
    ///     Decrypting encrypted data must always result in the onriginal data.
    ///
    ///         let data = Data(...)
    ///         data == decrypt(encrypt(data))
    ///
    /// - throws: Throws an error if unable to decrypt the input data.
    func decrypt(_ data: Data) throws -> Data
    
}
