import XCTest
@testable import NetConnect

final class NetConnectTests: XCTestCase {
    
    func testMessage() {
        do {
            let msg = Message()
            msg.body = Data(raw: "Hello World")
            let encodedMsg = msg.encoded()
            let decodedMsg = try Message(messageData: encodedMsg)
            let originalStr = "Hello World"
            if let decodedStr = String(bytes: decodedMsg.body) {
                print(originalStr)
                print(decodedStr)
                XCTAssert(decodedStr == originalStr)
            } else {
                XCTAssert(false)
            }
        } catch {
            XCTAssert(false)
        }
    }

    static var allTests = [
        ("testMessage", testMessage),
    ]
}
