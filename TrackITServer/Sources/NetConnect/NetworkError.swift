import Foundation

public enum NetworkError : Error {
    
    case UnableToConnectToHost(host: String)
    
    case SocketWriteError(errmsg: String)
    
    case InvalidPort(port: Int)
    
}
