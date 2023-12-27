import Foundation

extension Imposter {

    enum CodingKeys: String, CodingKey {
        case port
        case networkProtocol = "protocol"
        case allowCORS
        case rejectUnauthorized
        case ca
        case key
        case cert
        case mutualAuth
        case ciphers
        case name
        case stubs
        case recordRequests
        case defaultResponse
        case numberOfRequests
        case requests
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        port = try container.decode(Int.self, forKey: .port)
        networkProtocol = try container.decode(NetworkProtocol.self, forKey: .networkProtocol)

        switch networkProtocol {
        case .http:
            if let extraNetworkOptions = try? container.decodeIfPresent(Bool.self, forKey: .allowCORS) {
                self.extraNetworkOptions = .http(allowCORS: extraNetworkOptions)
            } else {
                extraNetworkOptions = nil
            }
        case .https:
            let allowCORS = try container.decodeIfPresent(Bool.self, forKey: .allowCORS)
            let rejectUnauthorized = try container.decodeIfPresent(Bool.self, forKey: .rejectUnauthorized)
            let ca = try container.decodeIfPresent(String.self, forKey: .ca)
            let key = try container.decodeIfPresent(String.self, forKey: .key)
            let cert = try container.decodeIfPresent(String.self, forKey: .cert)
            let mutualAuth = try container.decodeIfPresent(Bool.self, forKey: .mutualAuth)
            let ciphers = try container.decodeIfPresent(String.self, forKey: .cert)

            if
                allowCORS != nil
                || rejectUnauthorized != nil
                || ca != nil
                || key != nil
                || cert != nil
                || mutualAuth != nil
                || ciphers != nil
            {
                extraNetworkOptions = .https(
                    allowCORS: allowCORS,
                    rejectUnauthorized: rejectUnauthorized,
                    ca: ca,
                    key: key,
                    cert: cert,
                    mutualAuth: mutualAuth,
                    ciphers: ciphers
                )
            } else {
                extraNetworkOptions = nil
            }
        }

        name = try container.decodeIfPresent(String.self, forKey: .name)
        stubs = try container.decode([Stub].self, forKey: .stubs)
        defaultResponse = try container.decodeIfPresent(Is.self, forKey: .defaultResponse)
        recordRequests = try container.decodeIfPresent(Bool.self, forKey: .recordRequests)
        numberOfRequests = try container.decodeIfPresent(Int.self, forKey: .numberOfRequests)
        requests = try container.decodeIfPresent([Imposter.RecordedRequest].self, forKey: .requests)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(port, forKey: .port)
        try container.encode(networkProtocol, forKey: .networkProtocol)

        switch extraNetworkOptions {
        case .http(let allowCORS):
            try container.encode(allowCORS, forKey: .allowCORS)
        case .https(
            allowCORS: let allowCORS,
            rejectUnauthorized: let rejectUnauthorized,
            ca: let ca,
            key: let key,
            cert: let cert,
            mutualAuth: let mutualAuth,
            ciphers: let ciphers
        ):
            try container.encodeIfPresent(allowCORS, forKey: .allowCORS)
            try container.encodeIfPresent(rejectUnauthorized, forKey: .rejectUnauthorized)
            try container.encodeIfPresent(ca, forKey: .ca)
            try container.encodeIfPresent(key, forKey: .key)
            try container.encodeIfPresent(cert, forKey: .cert)
            try container.encodeIfPresent(mutualAuth, forKey: .mutualAuth)
            try container.encodeIfPresent(ciphers, forKey: .ciphers)
        case .none:
            break
        }

        try container.encodeIfPresent(name, forKey: .name)
        try container.encode(stubs, forKey: .stubs)
        try container.encodeIfPresent(defaultResponse, forKey: .defaultResponse)
        try container.encodeIfPresent(recordRequests, forKey: .recordRequests)
        try container.encodeIfPresent(numberOfRequests, forKey: .numberOfRequests)
        try container.encodeIfPresent(requests, forKey: .requests)
    }

}
