import Foundation
import MountebankSwift

extension JSON {
    public init(mergingObjects objects: [JSON]) {
        var result: [String: JSON] = [:]
        for object in objects {
            guard case .object(let dictionary) = object else {
                fatalError("Only use this initialiser with objects")
            }
            result.merge(dictionary) { $1 }
        }
        self = .object(result)
    }
}
