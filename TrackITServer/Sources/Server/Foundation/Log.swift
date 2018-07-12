//
// File         : Log.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-23
//

import Foundation
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

/// A collection of printing functions which perform file flush operations
/// after printing.
class Log {

    /// Output file for log information.
    ///
    /// If `nil` the stdout is used. If the defined file does not exist then a
    /// new file will be created.
    static var outFile: String? {
        didSet {
            if let path = outFile {
                if !FileManager.default.fileExists(atPath: path) {
                    FileManager.default.createFile(atPath: path, contents: nil)
                }
            }
        }
    }
    
    /// An enumeration of event labels that may be printed using `Log.event`.
    enum Event : String {
        case ok         = "[  OK  ]"
        case failure    = "[FAILED]"
        case info       = "[ INFO ]"
        case data       = "[ DATA ]"
        case test       = "[ TEST ]"
        case cont       = "[  ||  ]"
        case server     = "[SERVER]"
        case client     = "[CLIENT]"
        case config     = "[CONFIG]"
        case warning    = "[!!!!!!]"
    }
    
    
    /// Prints a message to stdout prefixed by an event label.
    ///
    /// Performs a file flush after printing.
    static func event(_ msg: String, event: Event) {
        write("\(event.rawValue)[\(Time.now.time)] \(msg)")
    }
    
    /// Prints a message to stdout and performs a file flush.
    static func msg(_ msg: String) {
        write(msg)
    }
    
    /// Prints a '\n' character to stdout and performs a file flush.
    static func linebreak() {
       write("\n")
    }

    /// Logs an event if `Config.verbose` is true.
    static func verbose(_ msg: String, event: Event) {
        if Config.verbose {
            Log.event(msg, event: event)
        }
    }

    /// Writes a given string to `outFile` if it exists or stdout if it doesn't.
    private static func write(_ str: String) {
        let s = str + "\n"
        if outFile != nil {
            if let fh = FileHandle(forWritingAtPath: outFile!) {
                fh.seekToEndOfFile()
                if let data = s.data(using: .utf8) {
                    fh.write(data)
                }
                fh.closeFile()
            } else {
                print(str)
            }
        } else {
            print(str)
        }
    }
    
}
