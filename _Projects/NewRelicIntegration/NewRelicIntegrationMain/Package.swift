// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewRelicIntegrationMain",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NewRelicIntegrationMain",
            targets: ["NewRelicIntegrationMain"]),
    ],
    dependencies: [
        .package(url: "https://github.com/newrelic/newrelic-ios-agent-spm", from: "7.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NewRelicIntegrationMain",
            dependencies: [
                .product(name: "NewRelic", package: "newrelic-ios-agent-spm")
            ]
        ),
        .testTarget(
            name: "NewRelicIntegrationMainTests",
            dependencies: ["NewRelicIntegrationMain"]),
    ]
)
