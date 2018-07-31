//
// File         : BarshartClass.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-03
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import XCTest
@testable import TrackITClient

class TrackITClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let str = getFoodDescription(foodID: 2)
        XCTAssert(str != nil)
        print(str ?? "nil")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
