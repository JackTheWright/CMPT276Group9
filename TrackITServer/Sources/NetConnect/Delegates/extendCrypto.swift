//
//  extendCrypto.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Keyi Huang
// Created On   : 2018-07-21

import UIKit
import Function
import CryptoSwift

class extendCrypto: Cryptographer{
    
    let key = "1234567890987654321"
    let iv = "1234567890987654321"
    let aes = try AES(key: key.bytes, blockMode: .CBC(iv: iv.bytes))
    
    func encrypt(_ data: Data) throws -> Data {
        
        let bytes = data.bytes
        let encrypted = try aes.encrypt(bytes)
        let data = Data(encrypted)
        return data
        
    }

    func decrypt(_ data: Data) throws -> Data{
        
        let bytes = data.bytes
        let decrypted = try aes.decrypt(bytes)
        let data = Data(decrypted)
        return data
    }
    
}
