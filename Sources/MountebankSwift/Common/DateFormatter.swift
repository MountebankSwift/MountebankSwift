import Foundation

struct DateFormatter {
    init () {}

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

    func formatToDate(_ isoDateString: String) -> Date {
        // swiftlint:disable:next force_unwrapping
        Self.isoDateFormatter.date(from: isoDateString)!
    }

    func formatFromDate(_ date: Date) -> String {
        Self.isoDateFormatter.string(from: date)
    }
}
