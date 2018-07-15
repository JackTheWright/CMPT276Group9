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

let isServer = true

if isServer {
    try? Config.load(from: "./srvconf.json")
    if let server = Server() {
        server.start()
    } else {
        print("Unable to construct server")
    }
} else {

    let interface = NetworkInterface()!
    interface.setTimeout(2)
    interface.connect(to: "app.trackitdiet.com", on: 60011) { host in
        do {
            var flags = Message.Flags()
            flags.set(MessageFlags.DBQuery)
            try host.send("""
            select foodDescription from 'food name' where foodId = 2;
            """, flags: flags)

            let reply = try host.receiveJSON()
            print(reply)

        } catch NetworkError.Timeout {
            print("Connection timed out")
        }
    }

}
