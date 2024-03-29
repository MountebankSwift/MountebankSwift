import Foundation

/// Empty protocol for easier usage of the Stub api.
/// The following symbols conform: ``Is``, ``Proxy``, ``Inject`` and ``Fault``
public protocol StubResponse: Codable, Equatable, Sendable {}
