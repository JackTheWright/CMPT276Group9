//
// File         : FixedWidthInteger+Bytes.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-20
//

import Foundation

public extension FixedWidthInteger {

    /// Constructs from and array of bytes.
    ///
    /// Returns `nil` if the size of the byte array is not exactly the size of
    /// the constructing integer (i.e. `bitWidth / 8`).
    init?(bytes: [UInt8]) {
        self.init()
        guard bytes.count == bitWidth / 8 else {
            return nil
        }
        var x: Self = 0
        for i in 0..<(bitWidth / 8) {
            let y = Self(bytes[i]) << (i * 8)
            x |= y
        }
        self = x
    }

    /// Convenience initializer from a data object.
    ///
    /// Calls `init?(bytes: [UInt8])` to perform the actual initialization.
    init?(bytes: Data) {
        self.init(bytes: bytes.map { $0 })
    }

    /// Returns the bytes of the integer.
    ///
    /// Bytes are in little endian encoding by default. For big endian encoding
    /// use `5.bigEndian.bytes` for example.
    var bytes: [UInt8] {
        var b = [UInt8](repeating: 0, count: bitWidth / 8)
        for i in 0..<(bitWidth / 8) {
            b[i] = UInt8(truncatingIfNeeded: self >> (i * 8))
        }
        return b
    }

}
