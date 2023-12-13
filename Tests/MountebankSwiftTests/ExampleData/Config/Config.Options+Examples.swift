import Foundation
@testable import MountebankSwift

extension Config.Options {
    enum Examples {
        static let simple = Example(value: Config.Options(
            port: 100,
            localOnly: false,
            ipWhitelist: [],
            origin: false,
            protofile: "file.proto",
            pidfile: "file.pid",
            log: Config.Options.Log(level: .info),
            noParse: false,
            formatter: "formater",
            configFile: "config.txt",
            allowInjection: true,
            debug: false
        ), json: [
            "allowInjection": true,
            "configFile": "config.txt",
            "debug": false,
            "formatter": "formater",
            "ipWhitelist": [
            ],
            "localOnly": false,
            "log": [
                "level": "info",
            ],
            "noParse": false,
            "origin": false,
            "pidfile": "file.pid",
            "port": 100,
            "protofile": "file.proto",
        ])
    }
}
