//
// File         : SocketTests.swift
// Module       : NetConnectTests
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-25
//

import XCTest
import Foundation
import Socket
@testable import NetConnect

final class SocketTests: XCTestCase {

    /// Tests the `StreamingSocket.Packet` class' ability to encode and decode
    /// into and from a `Data` object.
    func testPacket() {
        let id: Int32 = 32
        let count: Int32 = 512
        let data = "Hello World".data(using: .utf8)!
        let packet = StreamingSocket.Packet(id: id, count: count, data: data)
        let encoded = packet.encode()
        guard let decoded = StreamingSocket.Packet.decoding(from: encoded) else {
            XCTAssert(false)
            return
        }
        XCTAssert(decoded.id == id)
        XCTAssert(decoded.count == count)
        XCTAssert(decoded.data == data)
    }

    /// Local test of `StreamingSocket` class.
    ///
    /// Runs client and server simultaniously on localhost. Sends ~1MB of data
    /// from the client to the server and then back. Test is passed if the data
    /// recieved from the server is exactly the same as the client.
    ///
    /// This test is meant as a proof of concept for the data splitting and
    /// rebuilding systems and not a sufficient test of the sockets ability to
    /// compensate for dropped packets.
    func testReadWrite() {
        let readGroup = DispatchGroup()
        readGroup.enter()
        let transmissionData = //"Hello World".data(using: .utf8)!
            String(repeating: "x", count: 100000).data(using: .utf8)!
        let timeout: UInt = 1000
        let port = 4136

        // Read
        DispatchQueue.global().async {
            do {
                guard let socket = StreamingSocket() else {
                    XCTAssert(false)
                    return
                }
                defer {
                    socket.close()
                    readGroup.leave()
                }
                socket.timeout = timeout
                let data = try socket.listen(on: port)
                XCTAssert(data.data == transmissionData, "Corrupted Data")
                try socket.write(data: data.data, to: data.sender)
            } catch NetworkError.Timeout {
                print("timeout")
                XCTFail()
            } catch let e {
                XCTAssert(false, String(describing: e))
            }
        }

        // Write
        DispatchQueue.global().async {
            do {
                guard let socket = StreamingSocket() else {
                    XCTAssert(false)
                    return
                }
                guard let addr = Address(hostname: "127.0.0.1", port: port)
                else {
                    XCTAssert(false)
                    return
                }
                socket.timeout = timeout
                try socket.write(data: transmissionData, to: addr)
                let data = try socket.read()
                XCTAssert(data.data == transmissionData, "Corrupted Data")
            } catch NetworkError.Timeout {
                XCTAssert(false, "Connection timed out")
            } catch let e {
                XCTAssert(false, String(describing: e))
            }
        }
    }
    
    /// Remote test for the `StreamingSocket` class.
    ///
    /// Connects to secondary dev server, transmits 150kB of textual data
    /// (Shakespear's play Othello) to the server which will echo back the same
    /// data. Test is passed if the data received from the server is exactly
    /// the same as the data sent.
    ///
    /// During the transmission packets will be dropped; therefore, this test
    /// focuses of the sockets ability to recover from such an event.
    func testRemote() {
        let timeout: UInt? = 1000
        let port = 4136
        let str = try! String(
            contentsOfFile: "/users/jeremy/desktop/test-data.txt"
        )
        let transmissionData = str.data(using: .utf8)!
        guard let socket = StreamingSocket() else {
            XCTFail()
            return
        }
        guard let addr = Address(hostname: "192.168.10.25", port: port) else {
            XCTFail()
            return
        }
        socket.timeout = timeout
        do {
            try socket.write(data: transmissionData, to: addr)
            let response = try socket.read()
            XCTAssertEqual(response.data, transmissionData)
        } catch NetworkError.Timeout {
            print("\nConnection Timed Out\n")
            XCTFail()
        } catch let e {
            print("An error occured: \(e)")
            XCTFail()
        }
    }
    
    /// The server code for the `testRemote` function.
    ///
    /// Not meant to be a unit test.
    func server_testRemote() {
        let port = 4136
        guard let socket = StreamingSocket() else {
            exit(1)
        }
        socket.timeout = nil
        let data = try? socket.listen(on: port)
        if let d = data {
            print("echoing...")
            try? socket.write(data: d.data, to: d.sender)
        }
        socket.close()
    }

}
