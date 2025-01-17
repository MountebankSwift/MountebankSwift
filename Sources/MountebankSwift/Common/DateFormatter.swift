import Foundation

struct DateFormatter {
    init() {}

    static let shared = DateFormatter()

    func formatToDate(_ isoDateString: String) throws -> Date {
        let format = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
        return try format.parse(isoDateString)
    }

    func formatFromDate(_ date: Date) -> String {
        date.formatted(Date.ISO8601FormatStyle(includingFractionalSeconds: true).dateSeparator(.dash))
    }
}
