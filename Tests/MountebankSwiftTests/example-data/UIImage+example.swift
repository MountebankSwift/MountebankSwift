import Foundation
import MountebankSwift

#if os(macOS)
import Cocoa
typealias StubImage = NSImage
#elseif os(iOS) || os(tvOS)
import UIKit
typealias StubImage = UIImage
#endif

extension StubImage {
    // swiftlint:disable force_unwrapping
    static let example = StubImage(data: StubImage.exampleData)!
    static let exampleData = Data(base64Encoded: StubImage.exampleBase64String, options: .ignoreUnknownCharacters)!
    // swiftlint:enable force_unwrapping
    static let exampleBase64String = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAAXNSR0IArs4c6QAAAE" +
        "RlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAABaADAAQAAAABAAAABQAAAAB" +
        "/qhzxAAAAKUlEQVQIHWP8//8/AwMjI5CAgv//wTyEAFScCaYAmcYhCDQDWRUDkA8AEGsMAtJaFngAAAAASUVORK5CYII="
}
