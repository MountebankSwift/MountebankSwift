// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MountebankSwift",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "MountebankSwift",
            targets: ["MountebankSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.4"),
    ],
    targets: [
        .target(
            name: "MountebankSwift",
            dependencies: []
        ),
        .testTarget(
            name: "MountebankSwiftTests",
            dependencies: [
                "MountebankSwift",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            resources: [
                .copy("ExampleData/Files"),
            ]
        ),
    ]
)
