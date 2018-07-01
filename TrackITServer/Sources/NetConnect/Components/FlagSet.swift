//
// File         : FlagSet.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-01
//

import Foundation

/// A generic protocol that defines the framework for a set of flags that may
/// be used in conjunction with the `FlagComplex` structure.
public protocol FlagSet {
    
    associatedtype RawValue : FixedWidthInteger & BinaryInteger
    
    var rawValue: RawValue { get }
    
}
