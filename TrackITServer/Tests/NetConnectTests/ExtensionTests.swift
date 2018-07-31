//
// File         : ExtensionTests.swift
// Module       : NetConnectTests
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-28
//

import XCTest
import Foundation
@testable import NetConnect

final class ExtensionTests : XCTestCase {
    
    /// Test for `Array.get`
    func testArrayGet() {
        let array = [0, 1, 2, 3, 4, 5]
        XCTAssertNil(array.get(-1))
        XCTAssertNil(array.get(6))
        XCTAssertNotNil(array.get(0))
        XCTAssertNotNil(array.get(5))
        for i in 0..<array.count {
            if let x = array.get(i) {
                XCTAssertEqual(x, array[i])
            } else {
                XCTFail()
            }
        }
    }
    
    /// Test for `Array.set`
    func testArraySet() {
        var array = [0, 1, 2, 3, 4, 5]
        XCTAssertFalse(array.set(-1, to: 10))
        XCTAssertFalse(array.set(6, to: 10))
        XCTAssertTrue(array.set(0, to: 10))
        XCTAssertTrue(array.set(5, to: 10))
    }
    
}
