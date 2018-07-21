//
//  extendCrypto.swift
//  
//
//  Created by keyih on 7/21/18.
//

import UIKit
import Function
import CryptoSwift

class extendCrypto: Cryptographer{
    
    let key = "1234567890987654321"
    let iv = "1234567890987654321"
    let aes = try AES(key: key.bytes, blockMode: .CBC(iv: iv.bytes))
    
    func encrypt(_ data: Data) throws -> Data {
        
        let encrypted = try aes.encrypt(data.bytes)
        data = encrypted.toBase64()!
        return data
        
    }

    func decrypt(_ data: Data) throws -> Data{
        
        let decrypted = try aes.decrypt(data)
        data = String(data: Data(decrypted), encoding: .utf8)!
        return data
        
    }
    
}
