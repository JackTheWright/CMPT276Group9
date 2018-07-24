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

//try? Config.load(from: "./srvconf.json")
//Log.outFile = Config.outFile
//if let server = Server() {
//    server.start()
//} else {
//    print("Unable to construct server")
//}

let isServer = true

if isServer {

    let socket = try! UDPSocket()
    let readData = try! socket.listen(on: 60011)
    try! socket.write(readData.data, to: readData.address)

} else {

    let socket = try! UDPSocket()
    let shakespeare = try! String(contentsOfFile: "test-data.txt")
    let data = shakespeare.data(using: .utf8)!

    print("Sending \(data.count) bytes to the server...")
    let address = Address.create(hostname: "192.168.10.025", port: 60011)!
    try! socket.write(data, to: address)
    let reply = try! socket.read()
    print("Received \(reply.bytesRead) bytes from the server.")
    if reply.data == data {
        print("Received data is the same as the sent data.")
    } else {
        print("Error: Received data differs from the send data.")
    }

}
