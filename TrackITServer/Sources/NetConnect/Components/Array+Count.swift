//
// File         : Array+Count.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-24
//

import Foundation

public extension Array {

    /// Returns the number of elements in the array that satisfy a given boolean
    /// expression.
    ///
    /// - parameters:
    ///     - filter: The boolean expression that an element must satisfy to
    ///         contribute to the count.
    ///
    /// - returns: Returns the number of elements that satisfy the expression.
    ///
    /// - complexity: _O(n)_
    func count(where filter: @escaping (Element) -> Bool) -> Int {
        var n = 0
        for element in self {
            if filter(element) {
                n += 1
            }
        }
        return n
    }

}
