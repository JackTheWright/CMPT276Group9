//
// File         : Cryptographer.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-30
//

import Foundation
import CryptoSwift

/// Protocol for network transmission encryption delegates.
public protocol Cryptographer {
    
    let key = "1234567890987654321"
    let iv = "1234567890987654321"
    let aes = try AES(key: key.bytes, blockMode: .CBC(iv: iv.bytes))
    
    /// Returns an ecrypted version of the input data.
    ///
    /// - invariant:
    ///     Decrypting encrypted data must always result in the onriginal data.
    ///
    ///         let data = Data(...)
    ///         data == decrypt(encrypt(data))
    ///
    /// - throws: Throws an error if unable to encrypt the input data.
    func encrypt(_ data: Data) throws -> Data {

        let encrypted = try aes.encrypt(data.bytes)
        data = encrypted.toBase64()!
        return data
    
    }
    
    /// Returns a decrypted version of the input data.
    ///
    /// - invariant:
    ///     Decrypting encrypted data must always result in the onriginal data.
    ///
    ///         let data = Data(...)
    ///         data == decrypt(encrypt(data))
    ///
    /// - throws: Throws an error if unable to decrypt the input data.
    func decrypt(_ data: Data) throws -> Data{
    
        let decrypted = try aes.decrypt(encrypt(data))
        data = String(data: Data(decrypted), encoding: .utf8)!
        return data
    
    }
    
}
