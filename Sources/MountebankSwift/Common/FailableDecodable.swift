import Foundation

struct FailableDecodable<Value: Decodable>: Decodable {
    let value: Value?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self.value = try container.decode(Value.self)
        } catch {
            print("[Mountebank]: ❌ Unable to decode \(decoder.codingPath.map(\.stringValue)) as \(Value.self)")
            self.value = nil
        }
    }
}

struct FailableDictionaryDecodable<Key: Decodable & Hashable, Value: Decodable>: Decodable {
    let value: [Key: Value]
    init(from decoder: Decoder) throws {
        value = try decoder
            .singleValueContainer()
            .decode([Key: FailableDecodable<Value>].self)
            .reduce(into: [:], { partialResult, element in
                if let value = element.value.value {
                    partialResult[element.key] = value
                }
            })
    }
}
