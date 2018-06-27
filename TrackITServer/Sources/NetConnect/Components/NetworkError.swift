import Foundation

public enum NetworkError : Error {
    
    case UnableToConnectToHost(host: String)
    
    case SocketWriteError(String)
    
    case SocketReadError(String)
    
    case InvalidPort(port: Int)
    
    case Timeout
    
}
