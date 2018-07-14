//
// File         : ServerError.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation

enum ServerError : Error {

    var description: String {
        switch self {
        case let .Config(msg):
            return "Configuration Error: \(msg)"
        }
    }

    case Config(String)

}
