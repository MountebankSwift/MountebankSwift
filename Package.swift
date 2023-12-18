// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MountebankSwift",
    platforms: [
        .iOS(.v13),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "MountebankSwift",
            targets: ["MountebankSwift"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MountebankSwift",
            dependencies: []
        ),
        .testTarget(
            name: "MountebankSwiftTests",
            dependencies: ["MountebankSwift"],
            resources: [
                .copy("ExampleData/Files"),
            ]
        ),
    ]
)
