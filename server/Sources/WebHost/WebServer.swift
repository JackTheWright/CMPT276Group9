import Foundation
import Kitura
import KituraNet

public class WebServer {
    
    
    /// Map of url paths to `Listener` objects which are listening on that
    /// specific path.
    ///
    /// Listeners in this map have explicitly defined paths that do not contain
    /// any wildcard characters.
    private var explicitListeners = [URL : Listener]()
    
    /// Map of url path matching patterns to `Listerner` objects which listen on
    /// paths that match their specified pattern.
    private var genericListeners = [URL : Listener]()
    
    /// The listener to handle requests that do not have a listener defined in
    /// the `listeners` map.
    private var fallbackListener: Listener?
    
    /// The Kitura `Router` object used to recive requests from http clients.
    private var router: Router
    
    /// The KituraNet `HTTPServer` object that contains the boiler plate server
    /// implementation.
    private var httpServer: HTTPServer
    
    /// The port number that this web server is runnning on.
    public let port: Int
    
    
    /// Initializes member variables and defines the port number which the
    /// server will run on.
    public init (onPort port: Int) {
        self.port = port
        self.router = Router()
        self.httpServer = Kitura.addHTTPServer(onPort: port, with: router)
        
        router.get("/*") { request, response, next in
            let parsedUrl = request.parsedURL
            if let path = parsedUrl.path {
                let sender = Sender(request: request, response: response)
                guard var url = URL(string: path) else {
                    throw ServerError.InvalidPath
                }
                
                if let listener = self.explicitListeners[url] {
                    listener.onRequest(sender: sender)
                    next()
                } else {
                    // If no explicit listener is defined, then search through
                    // the generic listeners looking for a path that matches the
                    // requested path by continuously removing the last path
                    // element until a match is found. If no match is found then
                    // use the default listener is one exists.
                    while url.pathComponents.count > 1 {
                        for kv in self.genericListeners {
                            if url == kv.key {
                                kv.value.onRequest(sender: sender)
                                next()
                                return
                            }
                        }
                        url = url.deletingLastPathComponent()
                    }
                    
                    // If this line is reached, then there are no matching
                    // generic listeners.
                    if let listener = self.fallbackListener {
                        listener.onRequest(sender: sender)
                    }
                    next()
                }
            } else {
                throw ServerError.UnableToGetPath
            }
        } // router.get
    } // init
    
    
    /// Adds a delegate which will be called during the server startup stage.
    ///
    /// - parameter delegate: A closure statement which defines code to be run
    ///     during startup.
    ///
    /// This delegate is optional.
    public func onStartup(_ delegate: @escaping () -> Void) {
        httpServer.started(callback: delegate)
    }
    
    
    /// Adds a delegate which will handle errors thrown by the server.
    ///
    /// - parameter delegate: A closure statement or function which defines code
    ///     which will be called in the even of an error being thrown by the
    ///     server.
    ///
    /// This delegate is optional.
    public func onFailure(_ delegate: @escaping (Swift.Error) -> Void) {
        httpServer.failed(callback: delegate)
    }
    
    
    /// Adds a delegate which will be called when the server is stoped.
    ///
    /// - parameter delegate: A closure statment which defines code to be run
    ///     when the server is stopped.
    ///
    /// This delegate is optional.
    public func onStop(_ delegate: @escaping () -> Void) {
        httpServer.stopped(callback: delegate)
    }
    
    
    /// Assigns a default listener to this server.
    ///
    /// - parameter listener: The listener object to use a a default.
    ///
    /// If a request for a page that does not contain a listener is recieved,
    /// then the listener defined in this method will be used to handle the
    /// request.
    ///
    /// A default listener does not need to be defined for the server to work.
    /// However, if one is not defined then a blank page will simply be sent
    /// back to the requesting client.
    public func defaultListener(_ listener: Listener) {
        fallbackListener = listener
    }
    
    
    /// Assigns a default listener, in the form of a closure statement, to this
    /// server.
    ///
    /// - parameter callback: A closure statement defining code to be executed
    ///     by the fall-back listener when no other listeners are defined for
    ///     a specific request.
    ///
    /// A default listener does not need to be defined for the server to work.
    /// However, if one is not defined then a blank page will simply be sent
    /// back to the requesting client.
    public func defaultListener(_ callback: @escaping (Sender) -> Void) {
        defaultListener(BasicListener(callback))
    }
    
    
    /// Adds a listener object to a given url path.
    ///
    /// - parameters:
    ///     - listener: An object conforming to the `Listener` protocol which
    ///         defines the actions to take when a request is recieved on the
    ///         specified path.
    ///
    ///     - path: The path which this listener should revieve requests from.
    public func addListener(_ listener: Listener, to path: String) throws {
        if path.first != "/" {
            throw ServerError.InvalidPath
        }
        
        if path.contains("*") {
            if path.last != "*" {
                throw ServerError.InvalidPath
            }
            guard let url = URL(string: path) else {
                throw ServerError.InvalidPath
            }
            
            // Remove the '*' from the url so it can be matched with requests.
            genericListeners[url.deletingLastPathComponent()] = listener
        } else {
            guard let url = URL(string: path) else {
                throw ServerError.InvalidPath
            }
            explicitListeners[url] = listener
        }
    }
    
    
    /// Adds a listener, defined by a closure statement, to a given url path.
    ///
    /// - parameters:
    ///     - path: The path which this listener should recieve requests from.
    ///
    ///     - callback: A closure statement defining the code that should be
    ///         executed when a request is recieved on the designated path.
    public func addListener(to path: String,
                            _ callback: @escaping (Sender) -> Void) throws
    {
        try addListener(BasicListener(callback), to: path)
    }
    
    
    /// Starts this server.
    ///
    /// - important: This function throws the program into an endless loop of
    ///     recieving and responsing to requests. Once this method is called,
    ///     the only way to stop the progam is to kill the process manually or
    ///     have one of the listeners call this object's `stop` method.
    public func start() {
        Kitura.run()
    }
    
    
    /// Tells this server to stop listening to requests.
    public func stop() {
        httpServer.stop()
    }
    
} // public class WebServer
