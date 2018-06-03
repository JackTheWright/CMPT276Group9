import Foundation


public protocol Decodable {
    
    /// Constructs an instance of this object from raw bytes.
    init? (bytes: Data)
    
}
