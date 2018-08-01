//
// File         : FlagComplex.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-01
//

import Foundation

/// A structure containg a collection of modifiable bits which represent boolean
/// flags.
///
/// For simplicity's sake, one may think of this object as a compressed boolean
/// array. This object is modeled after C style bitwise flags.
public struct FlagComplex<SetType : FlagSet> : RawRepresentable {
    
    public typealias RawValue = SetType.RawValue
    
    /// The raw integer value of this complex.
    public private(set) var rawValue: RawValue
    
    /// Construct this complex with a value of 0.
    public init() {
        self.rawValue = 0
    }
    
    /// Construct this complex from a given value.
    public init(rawValue value: RawValue) {
        self.rawValue = value
    }
    
    
    /// Sets active, bits denoted in `flag`.
    ///
    /// - param flag: A flag containing the bits to set active in this complex.
    ///
    /// If `Flag.RawType` is not castable to `Self.RawType` then this method
    /// does nothing.
    public mutating func set<Flag>(_ flag: Flag) where Flag : FlagSet {
        if let f = flag.rawValue as? RawValue {
            rawValue |= f
        }
    }
    
    
    /// Sets active, the bits denoted in `complex`
    ///
    /// - param fc: A flag complex containig bits which are to be set
    ///   active in this complex.
    public mutating func set(_ fc: FlagComplex<SetType>) {
        rawValue |= fc.rawValue
    }
    
    
    /// Returns a new `FlagComplex` with the same state as this complex after
    /// setting certian bits defined in `flag`.
    ///
    /// - param flag: A flag containing bits to set active.
    public func setting<Flag : FlagSet>(_ flag: Flag) -> FlagComplex<SetType> {
        var complex = FlagComplex(rawValue: self.rawValue)
        complex.set(flag)
        return complex
    }
    
    
    /// Returns a new `FlagComplex` with the same state as this complex after
    /// setting certian bits defined in `fc`.
    ///
    /// - param fc: A complex containing bits to set active.
    public func setting(_ fc: FlagComplex<SetType>) -> FlagComplex<SetType> {
        var complex = FlagComplex(rawValue: self.rawValue)
        complex.set(fc)
        return complex
    }
    
    
    /// Removes a series of active bits defined by `flag` from this complex.
    ///
    /// - param flag: A flag containing bits to deactivate.
    public mutating func remove<Flag : FlagSet>(_ flag: Flag) {
        if let f = flag.rawValue as? RawValue {
            rawValue &= ~f
        }
    }
    
    
    /// Removes a series of active bits defined by `fc` from this complex.
    ///
    /// - param fc: A complex containing bits to deactivate.
    public mutating func remove(_ fc: FlagComplex<SetType>) {
        rawValue &= ~fc.rawValue
    }
    
    
    /// Returns a new `FlagComplex` with the same state as this complex after
    /// removing certian bits defined in `flag`.
    ///
    /// - param flag: A flag containing bits to decativate.
    public func removing<Flag : FlagSet>(_ flag: Flag) -> FlagComplex<SetType> {
        var complex = FlagComplex(rawValue: self.rawValue)
        complex.remove(flag)
        return complex
    }
    
    
    /// Returns a new `FlagComplex` with the same state as this complex after
    /// removing certian bits defined in `fc`.
    ///
    /// - param fc: A complex containing bits to deactivate.
    public func removing(_ fc: FlagComplex<SetType>) -> FlagComplex<SetType> {
        var complex = FlagComplex(rawValue: self.rawValue)
        complex.remove(fc)
        return complex
    }
    
    
    /// Returns `true` if the bits denoted in `flag` are active in this complex.
    ///
    /// - param flag: A flag to compare with this complex.
    ///
    /// If `Flag.RawType` is not castable to `Self.RawType` then this method
    /// returns `false`.
    public func get<Flag>(_ flag: Flag) -> Bool where Flag : FlagSet {
        if let f = flag.rawValue as? RawValue {
            return (rawValue & f) == f
        } else {
            return false
        }
    }
    
    
    /// Returns `true` if the bits denoted in `fc` are active in this complex.
    ///
    /// - param fc: A flag complex to compare with this complex.
    public func get(_ fc: FlagComplex<SetType>) -> Bool {
        return (rawValue & fc.rawValue) == fc.rawValue
    }
    
}
