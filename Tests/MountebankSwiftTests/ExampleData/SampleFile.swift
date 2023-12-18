import Foundation
@testable import MountebankSwift

enum SampleFile: String {
    case png = "sample.png"
    case jpg = "sample.jpg"
    case json = "sample.json"
    case pdf = "sample.pdf"
    case txt = "sample.txt"
    case mp4 = "sample.mp4"
    case html = "sample.html"

    var url: URL {
        // swiftlint:disable:next force_unwrapping
        Bundle.module.url(forResource: "Files/\(rawValue)", withExtension: nil)!
    }

    var data: Data {
        // swiftlint:disable:next force_try
        try! Data(contentsOf: url)
    }

    var string: String {
        // swiftlint:disable:next force_try
        try! String(contentsOf: url)
    }

    var body: Body {
        switch self {
        case .png, .jpg, .pdf, .mp4:
            return .data(data)
        case .json:
            // swiftlint:disable:next force_try
            return .json(try! testDecoder.decode(JSON.self, from: data))
        case .txt, .html:
            return .text(string)
        }
    }

    var mimeType: String {
        switch self {
        case .png:
            return MimeType.png.rawValue
        case .jpg:
            return MimeType.jpeg.rawValue
        case .json:
            return MimeType.json.rawValue
        case .pdf:
            return MimeType.pdf.rawValue
        case .txt:
            return MimeType.plainText.rawValue
        case .mp4:
            return MimeType.mpeg4.rawValue
        case .html:
            return MimeType.html.rawValue
        }
    }
}

private final class BundleToken {}
private let bundle = Bundle(for: BundleToken.self)
