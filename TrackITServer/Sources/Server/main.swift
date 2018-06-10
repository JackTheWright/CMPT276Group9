import Foundation
import NetConnect
import CryptoSwift

do {
    
    let aes = try AES(key: "keykeykeykeykeyk", iv: "drowssapdrowssap")
    let msg = "Hello World"
    let encrypted = try aes.encrypt(msg.bytes)
    let decrypted = try aes.decrypt(encrypted)
    let msg2 = String(bytes: decrypted, encoding: .utf8)
    print(msg2 ?? "Error")
    
} catch {
    print("An error occured")
}

//Log.event("build system", event: .ok)
