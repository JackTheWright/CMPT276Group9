//
// File         : LabelDispatch.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-27
//

import Foundation

/// Static class responsible for creating unique dispatch queue labels.
internal class LabelDispatch {
    
    private static var id = 0
    
    private static let prefix = "com.netconnect.dispatchq_"
    
    /// Returns a unique dispatch queue label with a common prefix.
    internal static func getLabel() -> String {
        id += 1
        return "\(prefix)\(id)"
    }
    
}
