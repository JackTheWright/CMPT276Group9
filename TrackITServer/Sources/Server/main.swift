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

let isServer = true

if isServer {
    try? Config.load(from: "./srvconf.json")
    if let server = Server() {
        server.start()
    } else {
        print("Unable to construct server")
    }
} else {
    let socket = try! UDPSocket()

    for i in 1...1000 {
        let str = "\(i)"
        let message = Message(str, flags: Message.Flags(), id: 100)!
        if let address = Address.create(hostname: "app.trackitdiet.com", port: 60011) {
            try! socket.write(data: message.rawData, to: address)
            guard let replyData = try? socket.read() else {
                print("unable to read")
                exit(1)
            }
            let reply = Message(from: replyData.data)!
            print(reply.string ?? "nil")
        }

    }
}
