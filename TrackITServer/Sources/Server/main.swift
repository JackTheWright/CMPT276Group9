//
// File         : main.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-23
//

import Foundation

try? Config.load(from: "./srvconf.json")
Log.outFile = Config.outFile
if let server = Server() {
    server.start()
} else {
    print("Unable to construct server")
}
