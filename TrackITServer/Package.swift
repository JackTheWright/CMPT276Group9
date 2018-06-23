// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Server",
    products: [
        .library(name: "NetConnect", targets: ["NetConnect"]),
        .executable(name: "Server", targets: ["Server"])
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "0.0.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "NetConnect", dependencies: ["Socket", "CryptoSwift", "SwiftyJSON"]),
        .target(name: "Server", dependencies: ["NetConnect"]),
        .testTarget(name: "NetConnectTests", dependencies: ["NetConnect"])
    ]
)
