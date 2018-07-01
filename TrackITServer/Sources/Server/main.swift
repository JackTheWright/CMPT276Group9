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
    do {
        let netif = try NetworkInterface()
        netif.connect(to: "192.168.10.24", on: port) { host in
            let greeting = "Hello Server, I'm \(IFAddress.localIP() ?? "nil")"
            print("Sending : \(greeting)")
            try host.send(greeting)
            let response = try host.receiveString()
            print("Received: \(response)")
        }
    } catch let e {
        print(e.localizedDescription)
    }
}

func server() {
    do {
        let netif = try NetworkInterface()
        netif.listen(on: port) { host in
            let greeting = try host.receiveString()
            print("Received: \(greeting)")
            let response = "Hello Client, I'm \(IFAddress.localIP() ?? "nil")"
            print("Sending : \(response)")
            try host.send(response)
        }
    } catch let e {
        print(e.localizedDescription)
    }
}
