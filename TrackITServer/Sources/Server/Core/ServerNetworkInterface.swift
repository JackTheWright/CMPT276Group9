//
// Created by Jeremy Schwartz on 2018-07-30.
//

import Foundation
import Threading
import NetConnect

class ServerNetworkInterface {

    fileprivate let dQueue = DispatchQueue(label: "com.trackit.interface")

    fileprivate let socket: StreamingSocket

    fileprivate let timeout: UInt? = 50

    var isActive = Atomic<Bool>(false)

    var inboundMessageQueue = ThreadedQueue<NodePacket>()

    var outboundMessageQueue = ThreadedQueue<NodePacket>()

    init() {
        guard let s = StreamingSocket() else {
            fatalError("Unable to create socket")
        }
        self.socket = s
    }

    func activate() {
        let port = Config.port
        isActive.store(true)
        socket.timeout = timeout
        dQueue.async {
            while self.isActive.load() {
                // Reading
                do {
                    let readData = try self.socket.listen(on: port)
                    if readData.data.count == 0 {
                        throw NetworkError.Timeout
                    }
                    guard let message = Message(from: readData.data) else {
                        throw NetworkError.MalformedMessage
                    }
                    print(readData.data.base64EncodedString())
                    let packet = NodePacket(
                            address: readData.sender,
                            message: message,
                            time: Time.now
                    )
                    self.inboundMessageQueue.enqueue(packet)
                } catch NetworkError.Timeout {
                    // do nothing on timeout
                } catch let e {
                    Log.event(String(describing: e), event: .warning)
                }
                // Writing
                do {
                    if let packet = self.outboundMessageQueue.safeDequeue() {
                        print("Writing packet: \(packet.message)")
                        try self.socket.write(
                                data: packet.message.rawData,
                                to: packet.address
                        )
                    }
                } catch let e {
                    Log.event(String(describing: e), event: .warning)
                }
            }
        }
    }

    func deactivate() {
        isActive.store(false)
    }

}
