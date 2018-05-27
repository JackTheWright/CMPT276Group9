import Foundation

/// The base protocol for all http request listener delegates.
public protocol Listener {
    
    /// Called when the listener recieves a request at the specified path.
    ///
    /// - parameter sender: A `Sender` object representing the client that
    ///     initiated the request.
    func onRequest(sender: Sender)
    
}


/// Wraps a closure/lambda statement into a `Listener` conformable class.
internal class BasicListener : Listener {
    
    let callback: (Sender) -> Void
    
    init (_ callback: @escaping (Sender) -> Void) {
        self.callback = callback
    }
    
    func onRequest(sender: Sender) {
        callback(sender)
    }
    
}
