import Foundation

/// Base protocol for any type that is sent using the Socket Stream system.
///
/// Datagrams must contain a 64-bit header at the begining of their encoded
/// data.
///
/// ## Datagram Header Format (64 bits)
/// 1. Size of the message in bytes (16-bit unsigned integer)
/// 2. Conversation thread identifier (16-bit integer)
/// 3. 16 1-bit flags used by the system to determin information about the
///    message (16 bits)
/// 4. 16 1-bit flags used by the receiver to how to process the message
///    (16 bits)
///
/// The remaining message data contains the body of the datagram. The body is
/// sent simply as a chunk of bytes; it is up to the receiving entity to
/// determin what to do with the body.
public protocol Datagram {
    
    /// The size of the datagram (including the 8-byte header) in bytes.
    ///
    /// This number is compared against the size of the datagram recieved to
    /// determine if any packets were dropped during the connection. If packet
    /// loss or corruption did occur then a message is sent back requesting
    /// that the corrupted datagram be send again.
    var size : Int { get }
    
    /// A unique 16-bit identifier used to tell the server which conversation
    /// this message belongs to. Identifiers are passed out during a handshake
    /// request and need to be used in all following datagrams until the
    /// conversation is over.
    var threadId : UInt16 { get }
    
    /// A series of `MessageFlags` combined together using a bitwise or.
    var flags : FlagComplex<MessageFlags> { get }
    
    /// Flags instructing the reciever on how to interpret the datagram. An
    /// example would be "SQL Query" or "User Credentials".
    var interpretationFlags : FlagComplex<MessageFlags> { get }
    
    
    /// Initializes this object from a byte sequence which has been recieved
    /// over the network.
    ///
    /// - throws: Throws a `MessagingError` if the datagram is corrupted (the
    ///   size attribute does not match the size of the datagram) or if part of
    ///   the header is missing or malformed.
    init (messageData: Data) throws
    
    
    /// The entire message (header included) encoded as a `Data` object. This
    /// method is used when sending the datagram.
    func encoded() -> Data
    
}
