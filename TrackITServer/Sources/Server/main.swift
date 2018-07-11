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
import Threading

let isServer = false

if isServer {
    try? Config.load(from: "./srvconf.json")
    if let server = Server() {
        server.start()
    } else {
        print("Unable to construct server")
    }
} else {

    let interface = NetworkInterface()!
    interface.setTimeout(5)
    interface.connect(to: "app.trackitdeit.com", on: Config.port) { host in
        for i in 1...10000 {
            try host.send("\(i)")
            let reply = try host.receiveString()
            print(reply)
        }
    }

}
