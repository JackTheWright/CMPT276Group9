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
import CryptoSwift
import SwiftyJSON

let isServer = true

if isServer {
    try? Config.load(from: "./srvconf.json")
    if let server = Server() {
        server.start()
    } else {
        print("Unable to construct server")
    }
} else {
    testClient()
}
