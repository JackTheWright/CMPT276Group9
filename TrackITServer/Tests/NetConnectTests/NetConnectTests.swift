//
// File         : NetConnectTests.swift
// Module       : NetConnectTests
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-23
//

import XCTest
import Socket
@testable import NetConnect

final class NetConnectTests: XCTestCase {
    
    /// Test `Message` class encoding and decoding.
    func testMessage() {
        let string = "Hello World"
        var flags = Message.Flags()
        flags.set(MessageFlags.Confirmation)
        guard let message = Message(string, flags: flags, id: 0)
        else {
            XCTAssert(false)
            return
        }
        XCTAssert(message.string == string)
        XCTAssert(message.size == message.rawData.count)
    }
    
    /// Test `FlagComplex` getting and setting.
    func testMessageFlags() {
        var flags = Message.Flags()
        flags.set(MessageFlags.HSConfirm)
        XCTAssert(!flags.get(MessageFlags.HSDeny))
        XCTAssert(flags.get(MessageFlags.HSConfirm))
        XCTAssert(flags.get(MessageFlags.Confirmation))
        XCTAssert(flags.get(MessageFlags.Handshake))
    }
    
    /// Simple test for `IFAddress` class.
    func testIFAddress() {
        print(IFAddress.localIP() ?? "nil")
    }

    static var allTests = [
        ("testMessage", testMessage),
        ("testIFAddress", testIFAddress),
        ("testMessageFlags", testMessageFlags)
    ]
}
