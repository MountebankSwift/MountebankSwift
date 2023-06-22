//
//  Response+Codable.swift
//
//
//  Created by Tieme van Veen on 22/06/2023.
//

import Foundation

enum ResponseDecodeError: Error {
    case invalidType
    case invalidBodyForTextBodyMode
    case invalidBodyForBinaryBodyMode
}

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
            throw ResponseDecodeError.invalidType
        }
    }
}

extension Stub.Response.Is {
    enum CodingKeys: String, CodingKey {
        case statusCode
        case headers
        case body
        case mode = "_mode"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(statusCode, forKey: .statusCode)
        try container.encodeIfPresent(headers, forKey: .headers)

        switch body {
        case .none:
            break
        case .text(let value):
            try container.encode(value, forKey: .body)
        case .json(let json):
            try container.encode(json, forKey: .body)
        case .data(let data):
            try container.encode(Stub.Response.Mode.binary, forKey: .mode)
            try container.encode(data, forKey: .body)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        headers = try container.decodeIfPresent([String: String].self, forKey: .headers)

        let mode = try container.decodeIfPresent(Stub.Response.Mode.self, forKey: .mode)

        guard container.contains(.body) else {
            body = nil
            return
        }

        switch mode {
        case .none, .text :
            if let text = try? container.decode(String.self, forKey: .body) {
                body = .text(text)
            } else if let json = try? container.decode(JSON.self, forKey: .body) {
                body = .json(json)
            } else {
                throw ResponseDecodeError.invalidBodyForTextBodyMode
            }
        case .binary:
            if let data = try? container.decode(Data.self, forKey: .body) {
                body = .data(data)
            } else {
                throw ResponseDecodeError.invalidBodyForBinaryBodyMode
            }
        }
    }
}

extension Stub.Response.Parameters {
    enum ParametersDecodingError: Error {
        case empty
    }

    enum CodingKeys: String, CodingKey {
        case repeatCount = "repeat"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.repeatCount = try? container.decode(Int.self, forKey: .repeatCount)

        if self.isEmpty {
            throw ParametersDecodingError.empty
        }
    }

    public func encode(to encoder: Encoder) throws {
        if self.isEmpty {
            return
        }

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(repeatCount, forKey: .repeatCount)
    }
}
