import Foundation
import Socket
import Dispatch
import NetConnect

var data = Data()

data.append(bytes: UInt64(0x123456789))

for byte in data {
    print(String(format: "%02x", byte))
}


let port = 60011

func server() {
    var shouldContinue = true
    guard let socket = try? Socket.create(family: .inet, type: .datagram, proto: .udp) else {
        print("[FAILED] Unable to create socket")
        return
    }
    
    do {
        try socket.udpBroadcast(enable: true)
        print("[  OK  ] Socket created")
        repeat {
            var data = Data(capacity: 4096)
            let client = try socket.listen(forMessage: &data, on: port)
            print("[ INFO ] Read \(client.bytesRead) bytes")
            let str = String(data: data, encoding: .utf8)
            if let s = str {
                print("[ DATA ] From client: \(s)")
                if let addr = client.address {
                    try socket.write(from: s, to: addr)
                    print("[  OK  ] Sending msg to client")
                } else {
                    print("[FAILED] Unable to get client address")
                }
            }
            
            if str == "quit" {
                print("[ INFO ] Shutting down server")
                shouldContinue = false
            }
        } while shouldContinue
    } catch let error {
        print(error)
        return
    }
}

func client() {
    do {
        let socket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
        try socket.udpBroadcast(enable: true)
        let addr = Socket.createAddress(for: "app.trackitdiet.com", on: Int32(port))!
        try socket.write(from: "Hello World", to: addr)
        print("[  OK  ] Send message")
        var data = Data(capacity: 4096)
        _ = try socket.readDatagram(into: &data)
        if let str = String(data: data, encoding: .utf8) {
            print("[  OK  ] Message from server: \(str)")
        } else {
            print("[FAILED] Unable to create string")
        }
        try socket.write(from: "quit", to: addr)
        var data2 = Data(capacity: 4096)
        _ = try socket.readDatagram(into: &data2)
        if let str = String(data: data2, encoding: .utf8) {
            print("[  OK  ] Message from server: \(str)")
        } else {
            print("[FAILED] Unable to create string")
        }
        
    } catch let error {
        print(error)
        return
    }
}


