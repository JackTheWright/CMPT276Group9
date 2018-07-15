//
// File         : TestManifests.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-09
//

import Foundation
import NetConnect
import SwiftyJSON
import PerfectSQLite
import Database

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
//    let node = InboundNode()!
//    node.activate()
//    sleep(5)
//    node.deactivate()
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

func testTimeLinux() {
    let time = Time.now
    print(time.fancy)
}

func testClient() {
    let client = NetworkInterface()!
    client.connect(to: "app.trackitdiet.com", on: Config.port) { server in
        Log.event("Entering Closure", event: .ok)
        try server.send("Hello World")
        Log.event("Sent Hello World", event: .ok)
        print(try server.receiveString())
        Log.event("Received Echo", event: .ok)
    }
}

func testDB() {
    let path = "./cnf.db"

    do {
        guard let db = Database(path: path) else {
            print("unable to open database")
            return
        }

        var result = try db.query("SELECT * FROM 'FOOD NAME' WHERE FOODID = 2")
        print(result.rowsAsJSON())
        result.addRow(["FoodID" : 42, "FoodDescription" : "The Food"])
        print(result.rowCount)

        print(result.rowsAsJSON())
        print(result.columnsAsJSON())
        let json = result.columnsAsJSON()
        guard let test = Table(jsonColumns: json) else {
            print("unable to remake table")
            return
        }
        print(result.rows)
        print(test.rows)
    } catch let e {
        print(e)
    }
}

func testCNF() {
    let cnf = NutrientFile(path: "./cnf.db")!
    do {
        let result = try cnf.getAllFoodNames()
        let json = result.rowsAsJSON()
        print(json)
    } catch let e {
        print(e)
    }
}
