// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MINIMAL",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MINIMAL",
            targets: ["MINIMAL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danielgindi/Charts.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MINIMAL",
            dependencies: [
                .product(name: "DGCharts", package: "DGCharts"),
            ]
        ),
        .testTarget(
            name: "MINIMALTests",
            dependencies: ["MINIMAL"]),
    ]
)
