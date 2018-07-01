//
// File         : NetworkErrorEvent.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-01
//

import Foundation

public enum NetworkErrorEvent : Error {
    
    /// A message describing the error.
    public var message: String {
        switch self {
        case let .RejectConnection(msg):
            return msg
        }
    }
    
    case RejectConnection(reason: String)
    
}
