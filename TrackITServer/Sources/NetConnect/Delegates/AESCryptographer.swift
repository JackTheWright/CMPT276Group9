//
// AESCryptographer.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Keyi Huang
// Created On   : 2018-07-21

import Foundation
import CryptoSwift

class AESCryptographer: Cryptographer{
    private let key: String
    private let iv: String
    private let aes: AES
    
    public init (key: String, iv: String){
        self.key = key
        self.iv = iv
        aes = try! AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
    }
    
    public func encrypt(_ data: Data) throws -> Data {
        
        let bytes = data.bytes
        let encrypted = try aes.encrypt(bytes)
        let data = Data(encrypted)
        return data
        
    }

    public func decrypt(_ data: Data) throws -> Data{
        
        let bytes = data.bytes
        let decrypted = try aes.decrypt(bytes)
        let data = Data(decrypted)
        return data
    }
    
}
