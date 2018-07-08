//
//  TestManifest.swift
//  Server
//
//  Created by Jeremy Schwartz on 2018-07-07.
//

import Foundation

let allTests = [
    ("Config", testConfig),
//    ("Node", testNode)
    ("Time", testTime),
]

func testAll() {
    for test in allTests {
        print("===== Starting Test: \(test.0) =====")
        test.1()
        print("===== Finished Test: \(test.0) =====")
        print()
    }
}

// MARK: Tests

func testConfig() {
    do {
        try Config.load(from: "./srvconf.json")
        print(Config.port)
        print(Config.verbose)
    } catch let e {
        if let se = e as? ServerError {
            print(se.description)
        }
    }
}


func testNode() {
    let node = InboundNode()!
    node.activate()
    sleep(5)
    node.deactivate()
}

func testTime() {
    var time = Time()
    print(time.date, time.fancy)
    time.month = 12
    print(time.date, time.fancy)
    time.month = 13
    print(time.date, time.fancy)
    time.month = 24
    print(time.date, time.fancy)
    time.month = 0
    print(time.date, time.fancy)
    print()
    print(time.lowestMinute.time)
    print(time.lowestHour.time)
}
