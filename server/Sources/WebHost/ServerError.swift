//
//  ServerError.swift
//  WebHost
//
//  Created by Jeremy S on 2018-05-26.
//

import Foundation

/// A set of errors that may be thrown by functions in the `WebHost` module.
public enum ServerError : Error {
    
    /// Thrown if a `ParsedURL.path` attribute is nil
    case UnableToGetPath
    
    /// Thrown if an invalid path was supplied when attempting to add a listener
    /// to a server object.
    case InvalidPath
}
