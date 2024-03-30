extension Proxy {
    enum CodingKeys: String, CodingKey {
        case to
        case mode
        case predicateGenerators
        case addWaitBehavior
        case addDecorateBehavior

        // http/https
        case injectHeaders
        case key
        case certificate = "cert"
        case ciphers
        case secureProtocol
        case passphrase
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        to = try container.decode(String.self, forKey: .to)
        mode = try container.decodeIfPresent(Mode.self, forKey: .mode)
        predicateGenerators = try container.decodeIfPresent([PredicateGenerator].self, forKey: .predicateGenerators)
        addWaitBehavior = try container.decodeIfPresent(Bool.self, forKey: .addWaitBehavior)
        addDecorateBehavior = try container.decodeIfPresent(String.self, forKey: .addDecorateBehavior)

        let injectHeaders = try container.decodeIfPresent(
            FailableDictionaryDecodable<String, String>.self,
            forKey: .injectHeaders
        )?.value
        let key = try container.decodeIfPresent(String.self, forKey: .key)
        let certificate = try container.decodeIfPresent(String.self, forKey: .certificate)
        let ciphers = try container.decodeIfPresent(String.self, forKey: .ciphers)
        let secureProtocol = try container.decodeIfPresent(String.self, forKey: .secureProtocol)
        let passphrase = try container.decodeIfPresent(String.self, forKey: .passphrase)
        if
            key != nil ||
            certificate != nil ||
            ciphers != nil ||
            secureProtocol != nil ||
            passphrase != nil
        {
            networkProtocolParameters = .https(
                injectHeaders: injectHeaders,
                key: key,
                certificate: certificate,
                ciphers: ciphers,
                secureProtocol: secureProtocol,
                passphrase: passphrase
            )
        } else if let injectHeaders {
            networkProtocolParameters = .http(injectHeaders: injectHeaders)
        } else {
            networkProtocolParameters = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(to, forKey: .to)
        try container.encodeIfPresent(mode, forKey: .mode)

        switch networkProtocolParameters {
        case .http(let injectHeaders):
            try container.encodeIfPresent(injectHeaders, forKey: .injectHeaders)
        case .https(let injectHeaders, let key, let certificate, let ciphers, let secureProtocol, let passphrase):
            try container.encodeIfPresent(injectHeaders, forKey: .injectHeaders)
            try container.encodeIfPresent(injectHeaders, forKey: .injectHeaders)
            try container.encodeIfPresent(key, forKey: .key)
            try container.encodeIfPresent(certificate, forKey: .certificate)
            try container.encodeIfPresent(ciphers, forKey: .ciphers)
            try container.encodeIfPresent(secureProtocol, forKey: .secureProtocol)
            try container.encodeIfPresent(passphrase, forKey: .passphrase)
        case .none:
            break
        }

        try container.encodeIfPresent(predicateGenerators, forKey: .predicateGenerators)
        try container.encodeIfPresent(addWaitBehavior, forKey: .addWaitBehavior)
        try container.encodeIfPresent(addDecorateBehavior, forKey: .addDecorateBehavior)
    }
}
