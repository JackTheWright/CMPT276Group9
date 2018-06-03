import Foundation

extension String : Encodable {
    
    public var data: Data {
        var d = Data(bytes: utf8.map { return $0 })
        d.append(0) // append null terminator
        return d
    }
    
}


extension String : Decodable {
    
    public init? (bytes: Data) {
        self.init(data: bytes, encoding: Encoding.utf8)
    }
    
}
