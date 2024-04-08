import Foundation

/// Contains predicates and responses.
/// The ``Imposter`` uses the stub if **all** of the stub's predicates match an incoming request.
/// Every time the stub is used it will return the next response in the list of its responses.
///
/// [mbtest.org/docs/api/contracts?type=stub](https://www.mbtest.org/docs/api/contracts?type=stub)
public struct Stub: Equatable, Sendable {
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

    /// Creates a stub with multiple responses and predicates
    ///
    /// The stub is used if **all** of the predicates match an incoming request.
    /// Every time the stub is used it will return the next response in the list of its responses.
    public init(responses: [any StubResponse], predicates: [Predicate]) {
        self.responses = responses
        self.predicates = predicates
    }

    /// Creates a stub with a single response and predicate
    ///
    /// The response is returned if the predicate matches an incoming request.
    public init(response: any StubResponse, predicate: Predicate) {
        self.init(responses: [response], predicates: [predicate])
    }

    /// Creates a stub with a multiple response and a single predicate
    ///
    /// The stub is used the predicate matches an incoming request
    /// Every time the stub is used it will return the next response in the list of its responses.
    public init(responses: [any StubResponse], predicate: Predicate) {
        self.init(responses: responses, predicates: [predicate])
    }

    /// Creates a stub with a single response and multiple predicates
    ///
    /// The response is returned when **all** of the predicates match an incoming request.
    public init(response: any StubResponse, predicates: [Predicate]) {
        self.init(responses: [response], predicates: predicates)
    }

    /// Creates a stub with a single response and no predicates
    ///
    /// The response is always used
    public init(response: any StubResponse) {
        self.init(responses: [response], predicates: [])
    }
}

extension Stub: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([responseProperty, predicateProperty], indent: indent)
    }

    private var responseProperty: (String, Recreatable) {
        if responses.count == 1, let codable = responses.first?.codable {
            switch codable {
            case .is(let response):
                return ("response", response)
            case .proxy(let response):
                return ("response", response)
            case .inject(let response):
                return ("response", response)
            case .fault(let response):
                return ("response", response)
            }
        } else {
            return ("responses", responses)
        }
    }

    private var predicateProperty: (String, Recreatable) {
        guard !predicates.isEmpty else {
            return ("predicates", [Predicate]())
        }

        return predicates.count == 1
            ? ("predicate", predicates[0])
            : ("predicates", predicates)
    }
}
