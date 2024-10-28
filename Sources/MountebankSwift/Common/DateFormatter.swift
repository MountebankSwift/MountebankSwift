import Foundation

struct DateFormatter {
    init() {}

    let isoDateFormatter: ISO8601DateFormatter = {
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
        // swiftlint:disable next force_unwrapping
        isoDateFormatter.date(from: isoDateString)!
    }

    func formatFromDate(_ date: Date) -> String {
        isoDateFormatter.string(from: date)
    }
}
