import Foundation


/// Enumeration of possible values for the `Message.flags` attribute. These
/// flags may be combined together using a bitwise or to create more complex
/// states.
public enum MessageFlags : UInt16, FlagSet {
    
    public typealias RawValue = UInt16
    
    /// Flag state with no active bits.
    case Null           = 0b0000_0000_0000_0000
    
    /// Flag denoting a 'handshake' message. Is used when initiating a new
    /// conversation with a server. Upon reciving a handshake message the
    /// server will set up a new conversation and reply with message flaged
    /// with `HSConfirm` and the body of said reply will contain the 16-bit
    /// thread identifier.
    case Handshake      = 0b0000_0000_0000_0101
    
    /// Flag denoting a confirmation of the previous action. Messages with this
    /// flag are sent back to senders to let them know that their previous
    /// request was handled.
    case Confirmation   = 0b0000_0000_0000_0010
    
    /// Combination of `Handshake` and `Confirmation` flags. Sent as a reply to
    /// a handshake request along with a new thread identifier.
    case HSComfirm      = 0b0000_0000_0000_0111
    
    /// Flag denoting whether the sender is expecting a reply back. If this flag
    /// is active then the reciever must send back a message, even if it is only
    /// a confirmation message.
    case ExpectingReply = 0b0000_0000_0000_0100
    
    /// If the size of the message is too large to express in 16 unsigned bits
    /// then this flag is triggered and the 64-bits that come after the header
    /// are used to express the size of the message.
    case Use64BitSize   = 0b0000_0000_0000_1000
    
    /// Flag which tells the reciver to resend the previous message. A message
    /// with this flag set will be automatically sent back if a corrupted
    /// datagram is recived.
    case ResendRequest  = 0b0000_0000_0000_1100
    
    /// Flag denoting the end of the conversation. Sent by the client to the
    /// server to close the conversation, the server will reply with a message
    /// containing `EndOfConvo | Confirmation` flags to let the client know
    /// that the conversation was ended successfully.
    case EndOfConvo     = 0b0100_0000_0000_0000
    
    /// Flag denoting that an error has occured somewhere in the server. If the
    /// client receives a message with this flag, it can assume that the
    /// conversation has been closed due to an exception being thrown. To
    /// re-establish connection with the server, the client must send a new
    /// handshake request.
    case Error          = 0b1000_0000_0000_0000
    
}
