//
// File         : Config.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation
import SwiftyJSON

class Config {
    
    fileprivate static var json = JSON()
    
    /// Logs an event if verbose is enabled.
    fileprivate static func verboseLog(_ msg: String) {
        if verbose {
            Log.event(msg, event: .config)
        }
    }
    
}

// MARK: Loading Methods

extension Config {

    /// Asserts that a given value is not nil.
    ///
    /// - parameters:
    ///     - value: The optional to assert.
    ///
    ///     - msg: An optional message that should be appended to the end of
    ///         the error message.
    ///
    /// - throws: Throws `ServerError.Config` if assertion failed.
    fileprivate static func assertNotNil(_ value: Any?, _ msg: String) throws {
        guard value != nil else {
            throw ServerError.Config("value is nil '\(msg)'")
        }
    }
    
    /// Load from json config file.
    ///
    /// - parameters:
    ///     - filename: The relative path to the config file.
    ///
    /// - throws: Throws an error if unable to find the file or unable to
    ///     convert the file's contents to json.
    static func load(from filename: String) throws {
        let fileContents = try String(contentsOfFile: filename)
        json = JSON(parseJSON: fileContents)

        try assertNotNil(json.dictionary?["cnf path"]?.string, "cnf path")
        try assertNotNil(json.dictionary?["udb path"]?.string, "udb path")
    }
    
}

// MARK: Computed Properties

extension Config {
    
    /// The inbound port number.
    static var port: Int {
        if let p = json.dictionary?["port"]?.int {
            return p
        } else {
            verboseLog("Failover 'port'")
            return defaultPort
        }
    }
    
    /// Verbose flag.
    static var verbose: Bool {
        if let v = json.dictionary?["verbose"]?.bool {
            return v
        } else {
            return defaultVerbose
        }
    }

    /// Path to the CNF database.
    ///
    /// No failover.
    static var cnfPath: String {
        if let path = json.dictionary?["cnf path"]?.string {
            return path
        } else {
            return "./cnf.db"
        }
    }

    /// Path to the user data database.
    ///
    /// No failover.
    static var userDBPath: String {
        if let path = json.dictionary?["udb path"]?.string {
            return path
        } else {
            return "./userInfo.db"
        }
    }

    static var outFile: String? {
        if let path = json.dictionary?["outfile"]?.string {
            return path
        } else {
            return nil
        }
    }
    
}

// MARK: Defaults

fileprivate extension Config {
    
    /// Failover port.
    static var defaultPort: Int {
        return 60011
    }
    
    /// Failover verbose flag.
    static var defaultVerbose: Bool {
        return true
    }
    
}
