import Foundation

extension Imposter {

    enum CodingKeys: String, CodingKey {
        case port
        case networkProtocol = "protocol"
        case allowCORS
        case rejectUnauthorized
        case certificateAuthority = "ca"
        case key
        case certificate = "cert"
        case mutualAuth
        case ciphers
        case name
        case stubs
        case recordRequests
        case defaultResponse
        case numberOfRequests
        case requests
    }

    private enum NetworkProtocol: String, Codable {
        case http
        case https
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        port = try container.decode(Int.self, forKey: .port)
        let networkProtocol = try container.decode(NetworkProtocol.self, forKey: .networkProtocol)

        switch networkProtocol {
        case .http:
            let allowCORS = try container.decodeIfPresent(Bool.self, forKey: .allowCORS)
            self.networkProtocol = .http(allowCORS: allowCORS)
        case .https:
            let allowCORS = try container.decodeIfPresent(Bool.self, forKey: .allowCORS)
            let rejectUnauthorized = try container.decodeIfPresent(Bool.self, forKey: .rejectUnauthorized)
            let certificateAuthority = try container.decodeIfPresent(String.self, forKey: .certificateAuthority)
            let key = try container.decodeIfPresent(String.self, forKey: .key)
            let certificate = try container.decodeIfPresent(String.self, forKey: .certificate)
            let mutualAuth = try container.decodeIfPresent(Bool.self, forKey: .mutualAuth)
            let ciphers = try container.decodeIfPresent(String.self, forKey: .ciphers)

            if
                allowCORS != nil
                || rejectUnauthorized != nil
                || certificateAuthority != nil
                || key != nil
                || certificate != nil
                || mutualAuth != nil
                || ciphers != nil
            {
                self.networkProtocol = .https(
                    allowCORS: allowCORS,
                    rejectUnauthorized: rejectUnauthorized,
                    certificateAuthority: certificateAuthority,
                    key: key,
                    certificate: certificate,
                    mutualAuth: mutualAuth,
                    ciphers: ciphers
                )
            } else {
                self.networkProtocol = .http()
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

        switch networkProtocol {
        case .http(let allowCORS):
            try container.encode(NetworkProtocol.http.rawValue, forKey: .networkProtocol)
            try container.encode(allowCORS, forKey: .allowCORS)
        case .https(
            allowCORS: let allowCORS,
            rejectUnauthorized: let rejectUnauthorized,
            certificateAuthority: let certificateAuthority,
            key: let key,
            certificate: let certificate,
            mutualAuth: let mutualAuth,
            ciphers: let ciphers
        ):
            try container.encode(NetworkProtocol.https.rawValue, forKey: .networkProtocol)
            try container.encode(allowCORS, forKey: .allowCORS)
            try container.encodeIfPresent(rejectUnauthorized, forKey: .rejectUnauthorized)
            try container.encodeIfPresent(certificateAuthority, forKey: .certificateAuthority)
            try container.encodeIfPresent(key, forKey: .key)
            try container.encodeIfPresent(certificate, forKey: .certificate)
            try container.encodeIfPresent(mutualAuth, forKey: .mutualAuth)
            try container.encodeIfPresent(ciphers, forKey: .ciphers)
        }

        try container.encodeIfPresent(name, forKey: .name)
        try container.encode(stubs, forKey: .stubs)
        try container.encodeIfPresent(defaultResponse, forKey: .defaultResponse)
        try container.encodeIfPresent(recordRequests, forKey: .recordRequests)
        try container.encodeIfPresent(numberOfRequests, forKey: .numberOfRequests)
        try container.encodeIfPresent(requests, forKey: .requests)
    }

}
