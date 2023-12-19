import Foundation
@testable import MountebankSwift

extension Imposter.RecordedRequest {
    enum Examples {
        static let simple = Example(
            value: Imposter.RecordedRequest(
                method: .get,
                path: "/200-path",
                requestFrom: "127.0.0.1",
                ip: "127.0.0.2",
                timestamp: Date(timeIntervalSince1970: 1702066146.263)
            ),
            json: [
                "method": "GET",
                "path": "/200-path",
                "requestFrom": "127.0.0.1",
                "ip": "127.0.0.2",
                "timestamp": "2023-12-08T20:09:06.263Z",
            ]
        )

        static let advanced = Example(
            value: Imposter.RecordedRequest(
                method: .get,
                path: "/200-path",
                query: ["query": "test"],
                headers: ["Content-Type": "JSON"],
                body: ["hello"],
                form: "form input",
                requestFrom: "127.0.0.1",
                ip: "127.0.0.2",
                timestamp: Date(timeIntervalSince1970: 1702066146.263)
            ),
            json: [
                "method": "GET",
                "path": "/200-path",
                "query": ["query": "test"],
                "headers": ["Content-Type": "JSON"],
                "body": ["hello"],
                "form": "form input",
                "requestFrom": "127.0.0.1",
                "ip": "127.0.0.2",
                "timestamp": "2023-12-08T20:09:06.263Z",
            ]
        )
    }
}
