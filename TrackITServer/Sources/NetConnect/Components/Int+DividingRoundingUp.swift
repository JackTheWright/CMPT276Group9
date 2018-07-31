//
// File         : Int+DividingRoundingUp.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-20
//

public extension Int {

    /// Returns the result of an integer division by `self` and `x` rounding the
    /// value up to the nearest integer if there is a remainder.
    ///
    /// ## Example:
    ///
    /// ```
    /// print(5.dividingRoundingUp(by: 2)
    /// // prints 3
    /// ```
    ///
    /// This function does not convert to floating point at any time so results
    /// will be precise.
    func dividingRoundingUp(by x: Int) -> Int {
        let qr = self.quotientAndRemainder(dividingBy: x)
        return qr.quotient + (qr.remainder == 0 ? 0 : 1)
    }

}
