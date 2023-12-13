import Foundation

/// A Stub as documented on:
/// [mbtest.org/docs/api/contracts?type=stub](https://www.mbtest.org/docs/api/contracts?type=stub)
public struct Stub: Codable, Equatable {
	enum CodingKeys: String, CodingKey {
        case responses
        case predicates
    }

    /// In the absence of a predicate, a stub always matches, and there's never a reason to add more than one stub to
    /// an imposter. Predicates allow imposters to have much richer behavior by defining whether or not a stub matches
    /// a request. When multiple stubs are created on an imposter, the first stub that matches is selected.
    public let predicates: [Predicate]

    /// An array of responses to return for this stub. The responses array defines a circular buffer - every time the
    /// stub is used for the request, the first response is pulled from the front of the responses array, evaluated,
    /// and pushed to the back of the array. This elegantly does what you want. In the common case, when you always
    /// want to return the same response, you just add one response to the array. More complex scenarios will require
    /// that the same endpoint returns a sequence of different responses for the same predicates. Simply add them all
    /// to the array in order. When the sequence finishes, it will start over. More complexity can be added by simply
    /// adding more responses to the array without complicating the contract.
    public let responses: [any StubResponse]

    public init(responses: [any StubResponse], predicates: [Predicate]) {
        self.responses = responses
        self.predicates = predicates
    }

    public init(response: any StubResponse, predicate: Predicate) {
        self.init(responses: [response], predicates: [predicate])
    }

    public init(responses: [any StubResponse], predicate: Predicate) {
        self.init(responses: responses, predicates: [predicate])
    }

    public init(response: any StubResponse, predicates: [Predicate]) {
        self.init(responses: [response], predicates: predicates)
    }
}
