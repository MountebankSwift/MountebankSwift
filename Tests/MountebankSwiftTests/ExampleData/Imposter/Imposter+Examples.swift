import XCTest
@testable import MountebankSwift

extension Imposter {
    enum Examples {

        private static let certificate = "-----BEGIN CERTIFICATE-----\nMIIB6TCCAVICCQCZgxbBD0CG4"
            + "zANBgkqhkiG9w0BAQUFADA5MQswCQYDVQQGEwJV\nUzETMBEGA1UECBMKU29tZS1TdGF0ZTEVMBMGA1UECh"
            + "MMVGhvdWdodFdvcmtzMB4X\nDTEzMTIyOTE2NDAzN1oXDTE0MDEyODE2NDAzN1owOTELMAkGA1UEBhMCVV"
            + "MxEzAR\nBgNVBAgTClNvbWUtU3RhdGUxFTATBgNVBAoTDFRob3VnaHRXb3JrczCBnzANBgkq\nhkiG9w0B"
            + "AQEFAAOBjQAwgYkCgYEAq77HtOGJMbVRmoMrxiQrL7+y03yyubkf2SCS\ng2Ap7hfgagczOJZKPDt/b8fi"
            + "8/RXxddV5fgjdWmN+2Lqy2DpXt3Qv6rJUm0A3tky\nTe5XFR1bLHj73DuSBMabzRVeS2LZsgjCiR8aZy"
            + "Ka7/7a1LKOaG6s814RVT1fUkGx\nR/7JyJ8CAwEAATANBgkqhkiG9w0BAQUFAAOBgQCPhixeKxIy+f"
            + "trfPikwjYo1uxp\ngQ18FdVN1pbI//IIx1o8kJuX8yZzO95PsCOU0GbIRCkFMhBlqHiD9H0/W/GvWz"
            + "jf\n7WFW15lL61y/kH1J0wqEgoaMrUDjHZvKVr0HrN+vSxHlNQcSNFJ2KdvZ5a9dhpGf\nXOdprCdUU"
            + "XzSoJWCCg==\n-----END CERTIFICATE-----"

        private static let privateKey = "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCrvse04YkxtVGagyvGJCsvv7LT"
            + "fLK5uR/ZIJKDYCnuF+BqBzM4\nlko8O39vx+Lz9FfF11Xl+CN1aY37YurLYOle3dC/qslSbQDe2TJN7lcVHVssePvc\nO5IExpv"
            + "NFV5LYtmyCMKJHxpnIprv/trUso5obqzzXhFVPV9SQbFH/snInwIDAQAB\nAoGARywlqLD6YO4qJiULw+4DM6N2oSwBCPRN3"
            + "XYhIW59kdy1NFtNf7rQgsuJUTJ9\nu+lbYnKNd2LwltyqaS4h7Sx5KRhpFNmMpyVsBf5J2q3fbfmrsXt+emY7XhVTc1NV\nizUWYy"
            + "xCoTTeMWvN/6NYpPV0lSxq7jMTFVZrWQUMqJclxpECQQDTlGwALtAX1Y8u\nGKsEHPkoq9bhHA5N9WAboQ4LQCZVC8eBf/XH//2i"
            + "osYTXRNgII2JLmHmmxJHo5iN\nJPFMbnoHAkEAz81osJf+yHm7PBBJP4zEWZCV25c+iJiPDpj5UoUXEbq47qVfy1mV\nDqy2zoDy"
            + "nAWitU7PeHyZ8ozfyribPoR2qQJAVmvMhXKZmvKnLivzRpXTC9LMzVwZ\nV6x/Wim5w8yrG5fZIMM0kEG2xwR3pZch/+SsCzl/0"
            + "aLLn6lp+VT6nr6NZwJBAMxs\nHrvymoLvNeDtiJFK0nHliXafP7YyljDfDg4+vSYE0R57c1RhSQBJqgBV29TeumSw\nJes6cFuqe"
            + "BE+MAJ9XxkCQDdUdhnA8HHQRNetqK7lygUep7EcHHCB6u/0FypoLw7o\nEUVo5KSEFq93UeMr3B7DDPIz3LOrFXlm7clCh"
            + "1HFZhQ=\n-----END RSA PRIVATE KEY-----"

        static let simple = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http,
                stubs: [Stub.Examples.text.value]
            ),
            json: [
                "port": 19190,
                "protocol": "http",
                "stubs": [Stub.Examples.text.json],
            ]
        )

        static let json = Example(
            value: Imposter(
                port: 100,
                networkProtocol: .http,
                stubs: [Stub.Examples.json.value]
            ),
            json: [
                "port": 100,
                "protocol": "http",
                "stubs": [Stub.Examples.json.json],
            ]
        )

        static let advanced = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .https,
                name: "Single stub",
                stubs: [
                    Stub.Examples.text.value,
                    Stub.Examples.json.value,
                    Stub.Examples.http404.value,
                ],
                defaultResponse: Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "https",
                "name": "Single stub",
                "stubs": [
                    Stub.Examples.text.json,
                    Stub.Examples.json.json,
                    Stub.Examples.http404.json,
                ],
                "defaultResponse": ["statusCode": 403],
                "recordRequests": true,
            ]
        )

        static let withResponseData = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .https,
                stubs: [Stub.Examples.text.value],
                recordRequests: true,
                numberOfRequests: 1,
                requests: [Imposter.RecordedRequest(
                    method: .get,
                    path: "/test-path",
                    requestFrom: "127.0.0.1",
                    ip: "127.0.0.1",
                    timestamp: Date(timeIntervalSince1970: 1702066146.263)
                )]
            ),
            json: [
                "port": 19190,
                "protocol": "https",
                "stubs": [Stub.Examples.text.json],
                "recordRequests": true,
                "numberOfRequests": 1,
                "requests": [
                    [
                        "method": "GET",
                        "path": "/test-path",
                        "requestFrom": "127.0.0.1",
                        "ip": "127.0.0.1",
                        "timestamp": "2023-12-08T20:09:06.263Z",
                    ],
                ],
            ]
        )

        static let withExtraOptionsHttp = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http,
                extraNetworkOptions: .http(allowCORS: true),
                stubs: [],
                recordRequests: false,
                numberOfRequests: 0,
                requests: []
            ),
            json: [
                "port": 19190,
                "protocol": "http",
                "allowCORS": true,
                "stubs": [],
                "numberOfRequests": 0,
                "requests": [],
                "recordRequests": false,
            ]
        )

        static let withExtraOptionsHttps = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .https,
                extraNetworkOptions: .https(
                    allowCORS: true,
                    rejectUnauthorized: true,
                    certificateAuthority: "-----BEGIN RSA KEY---- -----END RSA KEY-----",
                    key: privateKey,
                    certificate: certificate,
                    mutualAuth: false,
                    ciphers: "TLS_AES_256_GCM_SHA384"
                ),
                stubs: [],
                numberOfRequests: 1,
                requests: []
            ),
            json: [
                "port": 19190,
                "protocol": "https",
                "allowCORS": true,
                "rejectUnauthorized": true,
                "ca": "-----BEGIN RSA KEY---- -----END RSA KEY-----",
                "key": .string(privateKey),
                "cert": .string(certificate),
                "mutualAuth": false,
                "ciphers": "TLS_AES_256_GCM_SHA384",
                "stubs": [],
                "numberOfRequests": 1,
                "requests": [],
            ]
        )

        static let includingAllStubs = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .http,
                name: "Single stub",
                stubs: Stub.Examples.all.map(\.value),
                defaultResponse: Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "http",
                "name": "Single stub",
                "stubs": .array(Stub.Examples.all.map(\.json)),
                "defaultResponse": ["statusCode": 403],
                "recordRequests": true,
            ]
        )

        static let simpleRecordRequests = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http,
                stubs: [Stub.Examples.text.value],
                recordRequests: true
            ),
            json: [
                "port": 19190,
                "protocol": "http",
                "stubs": [Stub.Examples.text.json],
                "recordRequests": true,
            ]
        )
    }

}
