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
    
    func testSocket() {
        do {
            print()
            let socket = try UDPSocket()
            let rt = socket.setReadTimeout(3)
            print(rt ? "Timeout Set" : "Timeout not set")
            let _ = try socket.listen(on: 60000)
        } catch NetworkError.Timeout {
            print("Exception: Connection Timed Out")
        } catch let e {
            if let se = e as? Socket.Error {
                print(se.errorCode)
                print(se.errorReason ?? "nil")
            } else {
                print(e.localizedDescription)
            }
        }
        print()
    }
    
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
    
    func testMessageFlags() {
        var flags = Message.Flags()
        flags.set(MessageFlags.Confirmation)
        flags.set(MessageFlags.Encrypted)
        XCTAssert(flags.get(MessageFlags.Confirmation))
        XCTAssert(flags.get(MessageFlags.Encrypted))
        let message = Message(Data(), flags: flags, id: 0)
        XCTAssert(message.flags.get(MessageFlags.Confirmation))
        XCTAssert(message.flags.get(MessageFlags.Encrypted))
    }
    
    func testIFAddress() {
        print(IFAddress.localIP() ?? "nil")
    }

    static var allTests = [
        ("testSocket", testSocket),
        ("testMessage", testMessage),
        ("testIFAddress", testIFAddress),
        ("testMessageFlags", testMessageFlags)
    ]
}
