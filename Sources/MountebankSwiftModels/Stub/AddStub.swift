import Foundation

package struct AddStub: Codable, Equatable {
    package let index: Int?
    package let stub: Stub

    package init(index: Int? = nil, stub: Stub) {
        self.index = index
        self.stub = stub
    }
}
