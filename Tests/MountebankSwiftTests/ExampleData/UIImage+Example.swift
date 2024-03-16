import Foundation
import MountebankSwift

#if os(macOS)
import Cocoa

typealias StubImage = NSImage

#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit

typealias StubImage = UIImage

#elseif os(Linux)

struct StubImage {
    var data: Data

    init?(data: Data) {
        self.data = data
    }
}
#endif

// swiftlint:disable force_unwrapping

extension StubImage {
    static let image = StubImage(data: StubImage.example.value)!

    static let exampleBase64String = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAAXNSR0IArs4c6QAAAE" +
        "RlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAABaADAAQAAAABAAAABQAAAAB" +
        "/qhzxAAAAKUlEQVQIHWP8//8/AwMjI5CAgv//wTyEAFScCaYAmcYhCDQDWRUDkA8AEGsMAtJaFngAAAAASUVORK5CYII="

    static let example = Example(
        value: Data(base64Encoded: exampleBase64String, options: .ignoreUnknownCharacters)!,
        json: .string(exampleBase64String)
    )
}

// swiftlint:enable force_unwrapping
