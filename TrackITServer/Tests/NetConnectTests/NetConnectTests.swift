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
import CryptoSwift
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
        flags.set(MessageFlags.HSConfirm)
        XCTAssert(!flags.get(MessageFlags.HSDeny))
        XCTAssert(flags.get(MessageFlags.HSConfirm))
        XCTAssert(flags.get(MessageFlags.Confirmation))
        XCTAssert(flags.get(MessageFlags.Handshake))
    }
    
    func testIFAddress() {
        print(IFAddress.localIP() ?? "nil")
    }

    func testEncryption() {
        let key = "12345678901234567890123456789012"
        let iv = "1234567890123456"

        let s = try! String(contentsOfFile: "/users/jeremy/desktop/test-data.txt")
        let data = s.data(using: .utf8)!

        do {
            let crypt = try AESCryptographer(key: key, iv: iv)
            let encrypted = try crypt.encrypt(data)
            print("done encrypting")
            let decrypted = try crypt.decrypt(encrypted)
            print("done decrypting")
            let str = String(data: decrypted, encoding: .utf8)
            print(str == s)
        } catch let e {
            print(e)
        }
    }

    static var allTests = [
        ("testSocket", testSocket),
        ("testMessage", testMessage),
        ("testIFAddress", testIFAddress),
        ("testMessageFlags", testMessageFlags)
    ]
}
