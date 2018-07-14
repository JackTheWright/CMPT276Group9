// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Server",
    products: [
        .library(name: "NetConnect", targets: ["NetConnect"]),
        .library(name: "SwiftyJSON", targets: ["SwiftyJSON"]),
        .executable(name: "Server", targets: ["Server"])
    ],
    dependencies: [
        .package(url: "https://github.com/Miraion/Threading.git", from: "1.0.1"),
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "0.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "SwiftyJSON", dependencies: []),
        .target(name: "NetConnect", dependencies: ["Socket", "CryptoSwift", "SwiftyJSON"]),
        .target(name: "Server", dependencies: ["NetConnect", "Threading", "PerfectSQLite"]),
        .testTarget(name: "NetConnectTests", dependencies: ["NetConnect"])
    ]
)
