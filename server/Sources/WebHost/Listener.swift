import Foundation

/// The base protocol for all http request listener delegates.
public protocol Listener {
    
    /// Called when the listener recieves a request at the specified path.
    ///
    /// - parameter sender: A `Sender` object representing the client that
    ///     initiated the request.
    func onRequest(sender: Sender) throws
    
}


/// Wraps a closure/lambda statement into a `Listener` conformable class.
internal class BasicListener : Listener {
    
    let callback: (Sender) throws -> Void
    
    init (_ callback: @escaping (Sender) throws -> Void) {
        self.callback = callback
    }
    
    func onRequest(sender: Sender) throws {
        try callback(sender)
    }
    
}
