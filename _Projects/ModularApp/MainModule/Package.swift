// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainModule",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MainModule",
            targets: ["MainModule"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../UIModule")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MainModule",
            dependencies: []),
        .testTarget(
            name: "MainModuleTests",
            dependencies: ["MainModule"]),
    ]
)
