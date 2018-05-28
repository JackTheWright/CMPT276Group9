import Foundation
import WebHost


#if os(Linux)
let certPath = "/tmp/Certs/Self-Signed/certificate.pem"
let keyPath = "/tmp/Certs/Self-Signed/key.pem"
let ssl = SSLConfig(withCACertificateDirectory: nil,
                     usingCertificateFile: certPath,
                     withKeyFile: keyPath,
                     usingSelfSignedCerts: true)
let server = WebServer(onPort: 8080, withSSL: ssl)
#else
let server = WebServer(onPort: 8080)
#endif

try! server.addListener(to: "/") { sender in
    sender.reply("Root directory\n")
    if let query = sender.query {
        sender.reply("(\(query.key), \(query.value))")
    } else {
        sender.reply("No query")
    }
}

try! server.addListener(to: "/test/*") { sender in
    sender.reply("Testing page")
}

server.defaultListener { sender in
    sender.reply("Default page")
}

server.onFailure { error in
    Console.log("[FAILED] \(error.localizedDescription)")
}

server.start()
