// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-unix-sockets",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "swift-test-server-run", targets: ["TestServer"]),
        .executable(name: "swift-test-client-run", targets: ["TestClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kitura/BlueSocket.git", from:"1.0.8")
    ],
    targets: [
        .executableTarget(
            name: "TestServer",
            dependencies: [
                .product(name: "Socket", package: "BlueSocket")
            ]
        ),
        .executableTarget(
            name: "TestClient",
            dependencies: [
                .product(name: "Socket", package: "BlueSocket")
            ]
        ),
    ]
)
