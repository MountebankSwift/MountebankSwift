import Foundation

struct DateFormatter: @unchecked Sendable {
    init() {}

    static let shared = DateFormatter()

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

    func formatToDate(_ isoDateString: String) throws -> Date {
        if #available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *) {
            let format = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
            return try format.parse(isoDateString)
        } else {
            // swiftlint:disable:next force_unwrapping
            return Self.isoDateFormatter.date(from: isoDateString)!
        }
    }

    func formatFromDate(_ date: Date) -> String {
        if #available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *) {
            return date.formatted(Date.ISO8601FormatStyle(includingFractionalSeconds: true).dateSeparator(.dash))
        } else {
            return Self.isoDateFormatter.string(from: date)
        }
    }
}
