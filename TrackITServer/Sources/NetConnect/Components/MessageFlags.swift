//
// File         : MessageFlags.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-01
//

import Foundation

/// Enumeration of possible values for the `Message.flags` attribute. These
/// flags may be combined together using a bitwise or to create more complex
/// states.
public enum MessageFlags : UInt16, FlagSet {
    
    public typealias RawValue = UInt16
    
    /// Flag state with no active bits.
    case Null           = 0b0000_0000_0000_0000
    
    /// Flag denoting a 'handshake' message. Is used when initiating a new
    /// conversation with a server. Upon receiving a handshake message the
    /// server will set up a new conversation and reply with message flagged
    /// with `HSConfirm` and the body of said reply will contain the 16-bit
    /// thread identifier.
    case Handshake      = 0b0000_0000_0000_0101
    
    /// Flag denoting a confirmation of the previous action. Messages with this
    /// flag are sent back to senders to let them know that their previous
    /// request was handled.
    case Confirmation   = 0b0000_0000_0000_0010
    
    /// Combination of `Handshake` and `Confirmation` flags. Sent as a reply to
    /// a handshake request along with a new thread identifier.
    case HSConfirm      = 0b0000_0000_0000_0111
    
    /// Deny response to a handshake request.
    case HSDeny         = 0b0010_0000_0000_0001
    
    /// Flag denoting whether the sender is expecting a reply back. If this flag
    /// is active then the reciever must send back a message, even if it is only
    /// a confirmation message.
    case ExpectingReply = 0b0000_0000_0000_0100
    
    /// Flag which tells the receiver to resend the previous message. A message
    /// with this flag set will be automatically sent back if a corrupted
    /// datagram is received.
    case ResendRequest  = 0b0000_0000_0000_1100
    
    /// Flag denoted whether or not the message body is encrypted. If active,
    /// the receiver will attempt to decrypt the message body with its
    /// cryptographer delegate.
    case Encrypted      = 0b0000_0000_0001_0000
    
    /// Flag denoting the rejection of the previous request.
    case Deny           = 0b0010_0000_0000_0000
    
    /// Flag denoting the end of the conversation. Sent by the client to the
    /// server to close the conversation, the server will reply with a message
    /// containing `EndOfConvo | Confirmation` flags to let the client know
    /// that the conversation was ended successfully.
    case EndOfConvo     = 0b0100_0000_0000_0000
    
    /// Flag denoting that an error has occurred somewhere in the server. If the
    /// client receives a message with this flag, it can assume that the
    /// conversation has been closed due to an exception being thrown. To
    /// re-establish connection with the server, the client must send a new
    /// handshake request.
    case Error          = 0b1000_0000_0000_0000

    /// Flag denoting a database query message. (e.g. SELECT)
    case DBQuery    = 0b0000_0001_0000_0000

    /// Flag denoting a database action message. (e.g. INSERT, DELETE, etc.)
    case DBAction   = 0b0000_0010_0000_0000

    /// Flag requesting access to the CNF database.
    case CnfDB      = 0b0000_0000_1000_0000

    /// Flag requesting access to the user database.
    case UserDB     = 0b0000_0000_0100_0000

    /// Flag requesting echo handler.
    case Echo       = 0b0000_0000_0010_0000
    
}
