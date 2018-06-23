import Foundation
import NetConnect
import CryptoSwift
import SwiftyJSON

let jsonString =
"""
{
    "name" : "Maya",
    "age" : 18
}
"""

let data = jsonString.data(using: .utf8)!
let json = try! JSON(data: data)
let dic = json.dictionary!
print(dic)
print(dic["name"]?.string ?? "nil")
print(dic["age"]?.int ?? "nil")
