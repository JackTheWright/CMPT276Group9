//
//  CSV.swift
//  KT2
//
//  Created by Jeremy S on 2018-05-21.
//

import Foundation

class CSV {
    
    private var contents = [[String]]()
    
    /// Converts a string into a `[[String]]` object.
    ///
    /// Each line is represented as an internal array.
    private static func parseCsv(_ str: String) -> [[String]] {
        
    }
    
    /// Construct from string.
    init (_ string: String)  {
        
    }
    
    /// Construct from file with a given path.
    init (contentsOfFile path: String) throws {
        
    }
    
    var headers: [String] {
        return contents[0]
    }
    
}
