import Foundation

public extension Data {
    
    public init<T> (raw object: T) {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
        ptr.pointee = object
        self.init(bytes: UnsafeRawPointer(ptr), count: MemoryLayout<T>.size)
    }
    
    
    public mutating func append<Integer: FixedWidthInteger>(bytes int: Integer) {
        let byteCount = int.bitWidth / 8
        for i in 0..<byteCount {
            append(UInt8(Int((int >> (8 * i))) & 0xff))
        }
    }
    
}
