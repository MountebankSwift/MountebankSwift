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
        Bundle.module.url(forResource: "Files/\(rawValue)", withExtension: nil)!
    }

    var data: Data {
        try! Data(contentsOf: url)
    }

    var image: StubImage {
        StubImage(data: data)!
    }

    var string: String {
        try! String(contentsOf: url)
    }

    var body: Stub.Response.Body {
        switch self {
        case .png, .jpg, .pdf, .mp4:
            return .data(data)
        case .json:
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
