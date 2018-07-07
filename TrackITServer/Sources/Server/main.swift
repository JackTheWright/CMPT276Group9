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

// --- END TO END NETCONNECT TEST --- //

let port = 60000
let count = 1_000_000

let message = "RnVjayB4Zb3UgeSGAVyBZb3YmVydVA=="

var goodCount = 0
var badCount = 0

func client() {
    let netif = NetworkInterface()!
    netif.connect(to: "app.trackitdiet.com", on: port) { host in
        for _ in 1...count {
            try host.send(message)
        }
    }
}

func server() {
    let netif = NetworkInterface()!
    netif.listen(on: port) { host in
        for i in 1...count {
            let received = try host.receiveString()
            if received == message {
                goodCount += 1
            } else {
                badCount += 1
                print("Message was corrupted")
            }
            print("[ TEST ]# \(String(format: "% 7d", i)) - ", terminator: "")
            print("[  OK  ]# \(String(format: "% 7d", goodCount)) - ", terminator: "")
            print("[FAILED]# \(String(format: "% 7d", badCount)) ")
        }
    }
}


