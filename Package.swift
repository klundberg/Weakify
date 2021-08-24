// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Weakify",
    products: [
        .library(
            name: "Weakify",
            targets: ["Weakify"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Weakify",
            dependencies: []
        ),
        .testTarget(
            name: "WeakifyTests",
            dependencies: ["Weakify"]
        ),
    ]
)
