// swift-tools-version: 5.10
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
        .library(
            name: "MountebankSwiftModels",
            targets: ["MountebankSwiftModels"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.1"),
    ],
    targets: [
        .target(
            name: "MountebankSwift",
            dependencies: ["MountebankSwiftModels"],
            swiftSettings: [
                // Enable to validate if project is compatible with swift 6.0 Concurrency
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .target(
            name: "MountebankSwiftModels",
            dependencies: [],
            swiftSettings: [
                // Enable to validate if project is compatible with swift 6.0 Concurrency
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .target(
            name: "MountebankExampleData",
            dependencies: [
                "MountebankSwiftModels",
            ],
            resources: [
                .copy("Files"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "MountebankSwiftModelsTests",
            dependencies: [
                "MountebankSwiftModels",
                "MountebankExampleData",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            swiftSettings: [
                // Enable to validate if project is compatible with swift 6.0 Concurrency
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "MountebankSwiftTests",
            dependencies: [
                "MountebankSwift",
                "MountebankExampleData",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            swiftSettings: [
                // Enable to validate if project is compatible with swift 6.0 Concurrency
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
    ]
)
