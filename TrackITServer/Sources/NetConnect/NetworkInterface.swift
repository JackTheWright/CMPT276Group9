import Foundation
import Socket

public class NetworkInterface {
    
    public fileprivate(set) var port: Int
    private var socket: Socket
    
    /// Constructs this netwrok interface without connecting to any host.
    ///
    /// `connect(host: String, port: Int)` must be used to connect to a host
    /// after this object has been created.
    public init() throws {
        self.port = 0
        self.socket = try Socket.create(
            family: .inet,
            type: .datagram,
            proto: .udp
        )
        try socket.udpBroadcast(enable: true)
    }
    
    /// Connects this interface to an external host.
    ///
    /// - parameters:
    ///     - host: IPv4 address or fully qualified domain name of the host to
    ///             connect to.
    ///     - port: Connection port.
    public init(connectTo host: String, port: Int) throws {
        if port < 0 || port > UInt16.max {
            throw NetworkError.InvalidPort(port: port)
        }
        
        self.port = port
        self.socket = try Socket.create(
            family: .inet,
            type: .datagram,
            proto: .udp
        )
        try socket.connect(to: host, port: Int32(port))
        try socket.udpBroadcast(enable: true)
    }
    
    /// Convenience connection initializer; connects this interface to an
    /// external host.
    ///
    /// - parameters:
    ///     - host: IPv4 address or fully qualified domain name of the host to
    ///             connect to.
    ///
    /// The default connection port is used.
    public convenience init (connectTo host: String) throws {
        try self.init(connectTo: host, port: Config.port)
    }
    
    /// Connects to a given host on a given port.
    ///
    /// - parameters:
    ///     - host: IPv4 address or fully qualified domain name of the host to
    ///             connect to.
    ///     - port: Connection port.
    ///
    /// Should not be called if one of the `NetworkInterface(connectTo: String)`
    /// initializers has been used to contruct this object.
    public func connect(to host: String, on port: Int) throws {
        if port < 0 || port > UInt16.max {
            throw NetworkError.InvalidPort(port: port)
        }
        
        self.port = port
        try socket.connect(to: host, port: Int32(port))
    }
    
    /// Connects to a given host on the default port.
    ///
    /// - parameters:
    ///     - host: IPv4 address or fully qualified domain name of the host to
    ///             connect to.
    public func connect(to host: String) throws {
        try connect(to: host, on: Config.port)
    }
    
}
