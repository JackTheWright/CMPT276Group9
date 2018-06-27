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

    static var allTests = [
        ("testSocket", testSocket),
    ]
}
