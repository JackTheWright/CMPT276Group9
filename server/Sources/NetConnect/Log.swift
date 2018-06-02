//
//  Log.swift
//  Application
//
//  Created by Jeremy S on 2018-06-01.
//

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

/// A collection of printing functions which perform file flush operations
/// after printing.
public class Log {
    
    
    /// An enumeration of event labels that may be printed using `Log.event`.
    public enum Event : String {
        case ok         = "[  OK  ]"
        case failure    = "[FAILED]"
        case info       = "[ INFO ]"
        case data       = "[ DATA ]"
        case test       = "[ TEST ]"
        case cont       = "[  ||  ]"
        case server     = "[SERVER]"
        case client     = "[CLIENT]"
    }
    
    
    /// Prints a message to stdout prefixed by an event lable.
    ///
    /// Performs a file flush after printing.
    public static func event(_ msg: String, event: Event) {
        print("\(event.rawValue): \(msg)")
        fflush(stdout)
    }
    
    /// Prints a message to stdout and performs a file flush.
    public static func msg(_ msg: String) {
        print(msg)
        fflush(stdout)
    }
    
    /// Prints a '\n' character to stdout and performs a file flush.
    public static func linebreak() {
        print()
        fflush(stdout)
    }
    
}
