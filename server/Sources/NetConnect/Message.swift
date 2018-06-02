import Foundation

public class Message : Datagram {
    
   private var _size: Int
    
    
    /// The size of this message (including the 8-byte header) in bytes.
    ///
    /// If the `Use64BitSize` flag is set, then this value returns a 64-bit
    /// integer representing the size of the message; otherwise, a 16-bit
    /// integer is returned. Along with this, an extra 8-bytes are used to store
    /// the larger size variable so the overall size is 8-bytes larger.
    public var size: Int {
        if isOversized {
            return body.count + 16
        } else {
            return body.count + 8
        }
    }
    
    /// A unique 16-bit identifier used by the server to determine which
    /// conversation this message belongs to.
    public var threadId: UInt16
    
    /// A complex of flags used to identify aspects about this message.
    public var flags: FlagComplex<MessageFlags>
    
    /// A complex of flags used to determine how this message should be handled
    /// by the reciving system.
    public var interpretationFlags: FlagComplex<MessageFlags>
    
    
    private var _body = Data()
    
    /// The body of the message.
    public var body : Data {
        get {
            return _body
        }
        
        // Automatically set the oversized flag if body is too large.
        set {
            _body = newValue
            if _body.count + 64 >= UInt16.max {
                flags.set(MessageFlags.Use64BitSize)
            } else {
                flags.remove(MessageFlags.Use64BitSize)
            }
        }
    }
    
    
    /// Returns `true` if this message's `Use64BitSize` flag is set.
    internal var isOversized: Bool {
        return flags.get(MessageFlags.Use64BitSize)
    }
    
    
    public init() {
        self.threadId = 0
        self.flags = FlagComplex<MessageFlags>()
        self.interpretationFlags = FlagComplex<MessageFlags>()
        self._size = 0
    }
    
    
    /// Constructs a message object from an encoded chunk of data that is
    /// recieved over the network.
    public required init(messageData data: Data) throws {
        self.threadId = 0
        self.flags = FlagComplex<MessageFlags>()
        self.interpretationFlags = FlagComplex<MessageFlags>()
        self._size = 0
        
        
        let header = data.subdata(in: 0..<8)
        header.withUnsafeBytes { (ptr: UnsafePointer<UInt16>) in
            self._size = Int(ptr.pointee)
            self.threadId = ptr.advanced(by: 1).pointee
            self.flags = FlagComplex<MessageFlags>(
                rawValue: ptr.advanced(by: 2).pointee
            )
            self.interpretationFlags = FlagComplex<MessageFlags>(
                rawValue: ptr.advanced(by: 4).pointee
            )
        }
        self.body = data.subdata(in: 8..<data.count)
        if _size != size {
            throw MessagingError.MalformedMessage
        }
    }
    
    
    /// Returns an encoded version of this message that is ready to be sent.
    public func encoded() -> Data {
        var data = Data()
        if !isOversized {
            data.append(bytes: UInt16(size))
        } else {
            data.append(bytes: UInt16(0))
        }
        data.append(bytes: threadId)
        data.append(bytes: flags.rawValue)
        data.append(bytes: interpretationFlags.rawValue)
        data.append(body)
        return data
    }
    
}
