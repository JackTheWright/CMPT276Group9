import Foundation
import WebHost

let server = WebServer(onPort: 8080)

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
    print(error.localizedDescription)
}

server.start()
