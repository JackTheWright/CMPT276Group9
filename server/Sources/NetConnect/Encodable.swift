import Foundation

/// Protocol representing types that can be converted into raw data in the form
/// of an array of bytes. Also contains a convience method to convert object
/// into `Data` type.
public protocol Encodable {
    
    /// Returns a `Data` object containing data representing this object.
    var data : Data { get }
    
}
