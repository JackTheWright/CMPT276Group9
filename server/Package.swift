// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "server",
    products: [
        .library(name: "NetConnect", targets: ["NetConnect"]),
        .executable(name: "TrackITServer", targets: ["Application"])
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "NetConnect", dependencies: ["Socket"]),
        .testTarget(name: "NetConnectTests", dependencies: ["NetConnect"]),
        .target(name: "Application", dependencies: ["NetConnect"]),
    ]
)
