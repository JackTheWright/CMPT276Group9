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
    
    case UnableToConnectToHost(host: String)
    
    case SocketWriteError(String)
    
    case SocketReadError(String)
    
    case InvalidPort(port: Int)
    
    case Timeout
    
    case UnableToConvertStringToData
    
    case UnableToConvertDataToString
    
    case MalformedMessage
    
}
