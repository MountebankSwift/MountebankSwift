import MountebankSwift
import Testing

@Suite
struct LogsTests {

    @Test
    func logsSimple() throws {
        try assertEncode(
            Logs.Examples.simple.value,
            Logs.Examples.simple.json
        )
        try assertDecode(
            Logs.Examples.simple.json,
            Logs.Examples.simple.value
        )
    }

    @Test
    func logsWithDate() throws {
        try assertEncode(
            Logs.Examples.withDate.value,
            Logs.Examples.withDate.json
        )
        try assertDecode(
            Logs.Examples.withDate.json,
            Logs.Examples.withDate.value
        )
    }
}
