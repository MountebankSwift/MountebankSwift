# MountebankSwift

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMountebankSwift%2FMountebankSwift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MountebankSwift/MountebankSwift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMountebankSwift%2FMountebankSwift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/MountebankSwift/MountebankSwift)

A swift client library for the [Mountebank](https://www.mbtest.org/) - open source tool that
provides test doubles over the wire. It provides all the [api functionality](https://www.mbtest.org/docs/api/overview)
to interact with a running Mountebank instance.

![Mountebank logo holding a bottle with Swift's icon on it](MountebankSwift.jpg)

## Usage

Once [installed](#installation), you need to start the Mountebank server with `mb start`. You can import the
`MountebankSwift` module and setup `MountebankSwift` in your test.

```swift
import XCTest
import MountebankSwift

final class ExampleUITests: XCTestCase {

    private var mounteBank = Mountebank(host: .localhost)

    override func setUp() async throws {
        // Test if Mountebank is running if it failing please start Mountebank with `mb start`.
        try await mounteBank.testConnection()
    }

    override func tearDown() async throws {
        // Remove all imposters to have a clean Mountebank instance for the next tests.
        try await mounteBank.deleteAllImposters()
    }

    func testExample() throws {
        let stub = Stub(
            response: Is(statusCode: 201, body: .text("text")),
            predicate: .equals(Request(path: "/test"))
        )
        let imposter = Imposter(networkProtocol: .http, stubs: [stub])
        // Post the imposters to start testing against.
        try await mounteBank.postImposter(imposter: imposter)

        let app = XCUIApplication()
        app.launch()
    }
}
```

## Documentation

The documentation is available on the [Swift Package Index](https://swiftpackageindex.com/mountebankswift/mountebankswift/main/documentation) website.

## Installation

### Using Xcode

> **Warning**
> By default, Xcode will try to add the MountebankSwift package to your project's main application/framework target.
> Please ensure that MountebankSwift is added to a _test_ target instead, as documented in the last step, below.

 1. From the **File** menu, navigate through **Swift Packages** and select **Add Package Dependency…**.
 2. Enter package repository URL: `https://github.com/MountebankSwift/MountebankSwift`.
 3. Confirm the version and let Xcode resolve the package.
 4. On the last dialog, update MountebankSwift's **Add to Target** column to a test target that will contain
    tests that use Mountebank.

### Using Swift Package Manager

To add MountebankSwift to a project that uses [SwiftPM](https://swift.org/package-manager/), you can add it as a
dependency in `Package.swift`:

```swift
dependencies: [
  .package(
    url: "https://github.com/MountebankSwift/MountebankSwift",
    from: "1.0.0"
  ),
]
```

Next, add `MountebankSwift` as a dependency of your test target:

```swift
targets: [
  .target(name: "MyExampleApp"),
  .testTarget(
    name: "MyExampleAppTests",
    dependencies: [
      "MyExampleApp",
      .product(name: "MountebankSwift", package: "MountebankSwift"),
    ]
  )
]
```

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
