# MountebankSwift

A swift client library for the [Mountebank](https://www.mbtest.org/) - open source tool that
provides test doubles over the wire. It provides the [all api functionality](https://www.mbtest.org/docs/api/overview) 
to interact with a Mountebank instance running.

## Usage

Once [installed](#installation), you need to start the mountebank server with `mb start`. You can import the 
`MountebankSwift` module and setup `MountebankSwift` in your test.

```swift
import XCTest
import MountebankSwift

final class ExampleUITests: XCTestCase {

    private var mounteBank = Mountebank(host: .localhost)

    override func setUp() async throws {
        // Test if mountebank is running if it failing please start mountebank with `mb start`.
        try await mounteBank.testConnection()
    }

    override func tearDown() async throws {
        // Remove all imposters to have a clean mounteBank instance for the next tests.
        try await mounteBank.deleteAllImposters()
    }

    func testExample() throws {
        let stub = Stub(
            responses: [
                Stub.Response.`is`(Stub.Response.Is(statusCode: 201, body: .text("text")))
            ],
            predicates: []
        )
        let imposter = Imposter(networkProtocol: .http, stubs: [stub])
        // Post the imposters to start testing against.
        try await mounteBank.postImposter(imposter: imposter)

        let app = XCUIApplication()
        app.launch()
    }
}
```

## Installation

### Xcode

> **Warning**
> By default, Xcode will try to add the MountebankSwift package to your project's main application/framework target. 
> Please ensure that MountebankSwift is added to a _test_ target instead, as documented in the last step, below.

 1. From the **File** menu, navigate through **Swift Packages** and select **Add Package Dependency…**.
 2. Enter package repository URL: `https://github.com/MountebankSwift/MountebankSwift`.
 3. Confirm the version and let Xcode resolve the package.
 4. On the last dialog, update MountebankSwift's **Add to Target** column to a test target that will contain 
    tests that use mountebank.

### Swift Package Manager

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
