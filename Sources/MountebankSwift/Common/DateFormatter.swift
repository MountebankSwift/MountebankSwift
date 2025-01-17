import Foundation

struct DateFormatter: @unchecked Sendable {
    init() {}

    static let shared = DateFormatter()

    #if os(Linux)
    static let isoDateFormatter: ISO8601DateFormatter = {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds,
        ]

        return isoDateFormatter
    }()

    func formatToDate(_ isoDateString: String) -> Date {
        // swiftlint:disable:next force_unwrapping
        Self.isoDateFormatter.date(from: isoDateString)!
    }

    func formatFromDate(_ date: Date) -> String {
        Self.isoDateFormatter.string(from: date)
    }
    #else

    func formatToDate(_ isoDateString: String) throws -> Date {
        let format = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
        return try format.parse(isoDateString)
    }

    func formatFromDate(_ date: Date) -> String {
        date.formatted(Date.ISO8601FormatStyle(includingFractionalSeconds: true).dateSeparator(.dash))
    }
    #endif
}
