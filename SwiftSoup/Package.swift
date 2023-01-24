// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SwiftSoup",
    platforms: [
        .macOS(.v11),
        .iOS(.v16),
        .watchOS(.v7)
    ],
    products: [
        .library(name: "SwiftSoup", targets: ["SwiftSoup"])
    ],
    targets: [
        .target(name: "SwiftSoup", dependencies: [])
    ]
)
