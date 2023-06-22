//
//  Response+Codable.swift
//
//
//  Created by Tieme van Veen on 22/06/2023.
//

import Foundation

extension Stub.Response {
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
            if parameters?.isEmpty == false {
                try parameters?.encode(to: encoder)
            }
        case .proxy(let proxyData, let parameters):
            try container.encode(proxyData, forKey: .proxy)
            if parameters?.isEmpty == false {
                try parameters?.encode(to: encoder)
            }
        case .inject(let injectData, let parameters):
            try container.encode(injectData, forKey: .inject)
            if parameters?.isEmpty == false {
                try parameters?.encode(to: encoder)
            }
        case .fault(let faultData, let parameters):
            try container.encode(faultData, forKey: .fault)
            if parameters?.isEmpty == false {
                try parameters?.encode(to: encoder)
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var parameters: Parameters? = try Parameters(from: decoder)
        if parameters?.isEmpty == true {
            parameters = nil
        }

        if let isData = try container.decodeIfPresent(Is.self, forKey: .is) {
            self = .is(isData, parameters)
        } else if let proxyData = try container.decodeIfPresent(Proxy.self, forKey: .proxy) {
            self = .proxy(proxyData, parameters)
        } else if let injectData = try container.decodeIfPresent(String.self, forKey: .inject) {
            self = .inject(injectData, parameters)
        } else if let faultData = try container.decodeIfPresent(Fault.self, forKey: .fault) {
            self = .fault(faultData, parameters)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .is,
                in: container,
                debugDescription: "Invalid response type"
            )
        }
    }

}
