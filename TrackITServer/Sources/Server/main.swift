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
import PerfectSQLite

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
    interface.connect(to: "app.trackitdiet.com", on: 60011) { host in
        for i in 1...10000 {
            do {
                try host.send("\(IFAddress.localIP() ?? "no ip"): \(i)")
                let reply = try host.receiveData()
                print("Reply: \(reply.count) bytes, as string: " +
                        "\(String(data: reply, encoding: .utf8) ?? "nil")")
            } catch NetworkError.Timeout {
                print("Connection timed out; retrying...")
            }
        }
    }

}
