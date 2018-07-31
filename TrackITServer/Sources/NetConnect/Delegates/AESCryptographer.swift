//
// AESCryptographer.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Keyi Huang
// Created On   : 2018-07-21
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-23
//
//  - Removed force unwrapping of the `try` statement in initializer
//  - Added comments
//

import Foundation
import CryptoSwift

/// Implementation of the `Cryptographer` delegate using the AES-128 encryption
/// algorithm.
public class AESCryptographer: Cryptographer{
    private let key: String
    private let iv: String
    private let aes: AES

    /// Initializes the cryptographer using a key and iv.
    ///
    /// - parameters:
    ///     - key: A 32-byte encryption key that is used to encrypt and decrypt
    ///         the data presented to this cryptographer.
    ///
    ///     - iv: The initialization vector to be used when encrypting and
    ///         decrypting data. This number should be a random sequence of
    ///         bytes for best performance.
    ///
    /// - throws: Throws an error if unable to construct the underlying AES
    ///     object. This may be due to an invalid key or iv.
    public init (key: String, iv: String) throws {
        self.key = key
        self.iv = iv
        aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
    }

    /// Returns an encrypted version of the input data. To decrypt the output
    /// data, run it through the `decrypt` method.
    ///
    /// - parameters:
    ///     - data: The data to encrypt as a sequence of bytes.
    ///
    /// - returns: An encrypted version of the input data.
    ///
    /// - throws: Throws an error if unable to encrypt the input data.
    public func encrypt(_ data: Data) throws -> Data {
        let bytes = data.bytes
        let encrypted = try aes.encrypt(bytes)
        let data = Data(encrypted)
        return data
        
    }

    /// Returns a decrypted version of the input data.
    ///
    /// As expected, decrypting data that was encrypted using a different key
    /// will result in a garbage output. Also, attempting to decrypt data that
    /// was not originally encrypted or encrypted using a different algorithm
    /// will most likely case the method to throw an exception.
    ///
    /// - parameters:
    ///     - data: The data to decrypt.
    ///
    /// - returns: A decrypted version of the input data.
    ///
    /// - throws: Throws an error if unable to decrypt the data. This could be
    ///     the result of trying to decrypt data that was not encrypted in the
    ///     first place.
    public func decrypt(_ data: Data) throws -> Data{
        let bytes = data.bytes
        let decrypted = try aes.decrypt(bytes)
        let data = Data(decrypted)
        return data
    }
    
}
