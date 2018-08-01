//
// File         : main.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-23
//

import Foundation
import NetConnect


//let encryptionKey = "f171fed4cc458f2a1ed13a9f9f176b61"
//let initializationVector = "ZW5kIG1lIHBseg=="
//
//let crypt = try! AESCryptographer(key: encryptionKey, iv: initializationVector)
ServerLite.start(port: 60011, /* cryptographer: crypt */)
