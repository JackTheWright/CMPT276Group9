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

func client() {
    let netif = NetworkInterface()!
    netif.connect(to: "app.trackitdiet.com", on: port) { host in
        let greeting = "Hello Server, I'm \(IFAddress.localIP() ?? "nil")"
        print("Sending : \(greeting)")
        try host.send(greeting)
        let response = try host.receiveString()
        print("Received: \(response)")
    }
}

func server() {
    let netif = NetworkInterface()!
    netif.listen(on: port) { host in
        let greeting = try host.receiveString()
        print("Received: \(greeting)")
        let response = "Hello Client, I'm \(IFAddress.localIP() ?? "nil")"
        print("Sending : \(response)")
        try host.send(response)
    }
}
