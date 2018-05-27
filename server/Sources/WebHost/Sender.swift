import Foundation
import Kitura


/// Represents an http web client providing methods for gaining information
/// about the client and methods to send back data.
public class Sender {
    
    internal var request: RouterRequest
    
    internal var response: RouterResponse
    
    
    /// Initializes from Kitura's `RouterRequest` and `RouterResponse` objects.
    ///
    /// - parameters:
    ///     - request: The `RouterRequest` object passed from Kitura's
    ///         `Router.get` method.
    ///
    ///     - response: The `RouterResponse` object passed from Kitura's
    ///         `Router.get` method.
    internal init (request: RouterRequest, response: RouterResponse) {
        self.request = request
        self.response = response
    }
    
    
    /// Returns access to the internal `RouterRequest` object.
    public var info: RouterRequest {
        return request
    }
    
    
    /// Returns the query defined in the url if one exists, otherwise returns
    /// nil.
    ///
    /// An html query is defined as a key value pair staring with a '?' and
    /// separated by a '='. For example, the query in:
    ///
    /// `www.youtube.com/watch?v=xxxxxxxxxx`
    ///
    /// is the key value pair `("v", "xxxxxxxxxxx")`. In youtube's case the
    /// value would be a base 64
    /// number representing the video id.
    public var query: (key: String, value: String)? {
        if request.queryParameters.count == 1 {
            return (request.queryParameters.keys.first!,
                    request.queryParameters.values.first!)
        } else {
            return nil
        }
    }
    
    
    /// Sends a raw string back to the web client which made the request.
    ///
    /// - parameter text: Data to send to the web client as an utf8 formated
    ///     string.
    ///
    /// If the client is a web browser, then this text will show up as
    /// unformated text in the browser. Alternativly, `text` may also be a
    /// string containing html code, which will be displayed properly in a web
    /// browser.
    public func reply(_ text: String) {
        response.send(text)
    }

    
    /// Sends a block of binary data back to the web client which made the
    /// request.
    ///
    /// - parameter data: The chunk of binary data to send back to the web
    ///     client. It is up to the client to interpret this data however it
    ///     sees fit.
    ///
    /// This method may be used to send non-text data like images, video,
    /// javascript, html back to a browser.
    public func reply(_ data: Data) {
        response.send(data: data)
    }
    
    
    /// Sends an object with a `description` attribute.
    public func reply(_ obj: CustomStringConvertible) {
        response.send(obj.description)
    }
    
    
    /// Sends an object with a `debugDescription` attribute.
    public func reply(_ obj: CustomDebugStringConvertible) {
        response.send(obj.debugDescription)
    }
    
}
