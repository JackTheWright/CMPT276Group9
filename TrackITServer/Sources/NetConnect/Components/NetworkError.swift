//
// File         : NetworkError.swift
// Module       : NetConnect
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-06-01
//

import Foundation

public enum NetworkError : Error {
    
    public var description: String {
        switch self {
        case let .UnableToConnectToHost(host):
            return "Unable to connect to \(host)"
        case let .SocketWriteError(error):
            return "Socket Write Error: \(error)"
        case let .SocketReadError(error):
            return "Socket Read Error: \(error)"
        case let .InvalidPort(port):
            return "Invalid Port: \(port)"
        case .Timeout:
            return "Connection timed out"
        case .UnableToConvertStringToData:
            return "Unable to convert string to data"
        case .UnableToConvertDataToString:
            return "Unable to convert data to string"
        case .MalformedMessage:
            return "Malformed message"
        }
    }
    
    case UnableToConnectToHost(host: String)
    
    case SocketWriteError(String)
    
    case SocketReadError(String)
    
    case InvalidPort(port: Int)
    
    case Timeout
    
    case UnableToConvertStringToData
    
    case UnableToConvertDataToString
    
    case MalformedMessage
    
}
