import Foundation
@testable import MountebankSwift

extension Config.Process {
    enum Examples {
        static let simple = Example(value: Config.Process(
            nodeVersion: "12.0.1",
            architecture: "x86",
            platform: "macOS",
            rss: 10,
            heapTotal: 100,
            heapUsed: 10,
            uptime: 10.0,
            cwd: "/user/bin/mb"
        ), json: [
            "architecture": "x86",
            "cwd": "/user/bin/mb",
            "heapTotal": 100,
            "heapUsed": 10,
            "nodeVersion": "12.0.1",
            "platform": "macOS",
            "rss": 10,
            "uptime": 10,
        ])
    }
}
