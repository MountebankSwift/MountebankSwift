import Foundation

extension Stub.Response {
    enum DecodingError: Error {
        case invalidType
    }

    enum CodingKeys: String, CodingKey {
        case `is`
        case proxy
        case inject
        case fault
        case `repeat`
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .is(let isData, let parameters):
            try container.encode(isData, forKey: .is)
            try parameters?.encode(to: encoder)
        case .proxy(let proxyData, let parameters):
            try container.encode(proxyData, forKey: .proxy)
            try parameters?.encode(to: encoder)
        case .inject(let injectData, let parameters):
            try container.encode(injectData, forKey: .inject)
            try parameters?.encode(to: encoder)
        case .fault(let faultData, let parameters):
            try container.encode(faultData, forKey: .fault)
            try parameters?.encode(to: encoder)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let parameters = try? Parameters(from: decoder)
        if let isData = try container.decodeIfPresent(Is.self, forKey: .is) {
            self = .is(isData, parameters)
        } else if let proxyData = try container.decodeIfPresent(Proxy.self, forKey: .proxy) {
            self = .proxy(proxyData, parameters)
        } else if let injectData = try container.decodeIfPresent(String.self, forKey: .inject) {
            self = .inject(injectData, parameters)
        } else if let faultData = try container.decodeIfPresent(Fault.self, forKey: .fault) {
            self = .fault(faultData, parameters)
        } else {
            throw DecodingError.invalidType
        }
    }
}
