//
// File         : SQLiteElement.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-14
//

import Foundation

public struct SQLiteElement {

    fileprivate var raw: Any

    public init(_ raw: Any) {
        self.raw = raw
    }

    public var string: String? {
        return raw as? String
    }

    public var int: Int? {
        return raw as? Int
    }

    public var double: Double? {
        return raw as? Double
    }

    public var data: Data? {
        return raw as? Data
    }

    public var bool: Bool? {
        return raw as? Bool
    }

    public var any: Any {
        return raw
    }

}
