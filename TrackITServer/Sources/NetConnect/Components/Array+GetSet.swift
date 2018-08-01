//
//  Array+At.swift
//  NetConnect
//
//  Created by Jeremy Schwartz on 2018-07-28.
//

import Foundation

public extension Array {
    
    /// Random access getter for contained elements with soft bounds checking.
    ///
    /// Will return `nil` if `i` is outside of the bounds of the array.
    ///
    /// - parameters:
    ///     - i: The index at which to return an element. No assumptions are
    ///         made about whether `i` is a valid index for the array.
    ///
    /// - returns: The element at index `i` or `nil` if `i` is ot within the
    ///     bounds of the array.
    func get(_ i: Index) -> Element? {
        if i >= 0 && i < count {
            return self[i]
        } else {
            return nil
        }
    }
    
    /// Random access setter for contained elements with soft bounds checking.
    ///
    /// Will set the element at position `i` to be `newElement` if and only if
    /// `i` is a valid index. If not, then this method returns `false` and does
    /// nothing.
    ///
    /// - parameters:
    ///     - i: The index at witch to place the new element. No assumptions are
    ///         made about whether `i` is a valid index for the array.
    ///
    ///     - newElement: The element to place at index `i` if `i` is a valid
    ///         index.
    ///
    /// - returns: Returns `true` if the element was place succesfully, `false`
    ///     otherwise.
    @discardableResult
    mutating func set(_ i: Index, to newElement: Element) -> Bool {
        if i >= 0 && i < count {
            self[i] = newElement
            return true
        } else {
            return false
        }
    }
    
    /// Random access getter for contained elements with soft bounds checking.
    ///
    /// Will return `nil` if `i` is outside of the bounds of the array.
    ///
    /// - parameters:
    ///     - i: The index at which to return an element. No assumptions are
    ///         made about whether `i` is a valid index for the array.
    ///
    /// - returns: The element at index `i` or `nil` if `i` is ot within the
    ///     bounds of the array.
    func get<I>(_ i: I) -> Element? where I : BinaryInteger {
        return get(Int(i))
    }
    
    /// Random access setter for contained elements with soft bounds checking.
    ///
    /// Will set the element at position `i` to be `newElement` if and only if
    /// `i` is a valid index. If not, then this method returns `false` and does
    /// nothing.
    ///
    /// - parameters:
    ///     - i: The index at witch to place the new element. No assumptions are
    ///         made about whether `i` is a valid index for the array.
    ///
    ///     - newElement: The element to place at index `i` if `i` is a valid
    ///         index.
    ///
    /// - returns: Returns `true` if the element was place succesfully, `false`
    ///     otherwise.
    @discardableResult
    mutating func set<I>(_ i: I, to newElement: Element) -> Bool
        where I : BinaryInteger
    {
        return set(Int(i), to: newElement)
    }
    
}
