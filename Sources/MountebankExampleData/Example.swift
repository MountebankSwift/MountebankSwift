import Foundation
import MountebankSwift
import MountebankSwiftModels

struct Example<CodableEquatableType: Codable & Equatable & Sendable> {
    let value: CodableEquatableType
    let json: JSON
}
