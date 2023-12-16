import Foundation

struct AddStub: Codable, Equatable {
    let index: Int?
    let stub: Stub

    init(index: Int? = nil, stub: Stub) {
        self.index = index
        self.stub = stub
    }
}
