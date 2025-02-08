import InlineSnapshotTesting
import XCTest
@testable import MountebankSwift
@testable import MountebankSwiftModels

final class RecreatableTests: XCTestCase {
    struct MyStruct: Recreatable {
        let foo: String?
        let bar: [Int]
        let enumValue: MyEnum
        let json: JSON?

        func recreatable(indent: Int) -> String {
            structSwiftString([
                ("foo", foo),
                ("bar", bar),
                ("enumValue", enumValue),
                ("json", json),
            ], indent: indent)
        }
    }

    indirect enum MyEnum: Recreatable {
        case simple
        case associatedValue(String)
        case namedAssociatedValues(foo: String, bar: String)
        case structValue(structValue: MyStruct)

        func recreatable(indent: Int) -> String {
            switch self {
            case .simple:
                return enumSwiftString(indent: indent)
            case .associatedValue(let string):
                return enumSwiftString([string], indent: indent)
            case .namedAssociatedValues(let foo, let bar):
                return enumSwiftString([("foo", foo), ("bar", bar)], indent: indent)
            case .structValue(let structValue):
                return enumSwiftString([("structValue", structValue)], indent: indent)
            }
        }
    }

    func testString() {
        assertInlineSnapshot(of: "some string value".recreatable(indent: 0), as: .lines) {
            """
            "some string value"
            """
        }
    }

    func testInt() {
        assertInlineSnapshot(of: 42.recreatable(indent: 0), as: .lines) {
            """
            42
            """
        }
    }

    func testDouble() {
        assertInlineSnapshot(of: 42.0.recreatable(indent: 0), as: .lines) {
            """
            42.0
            """
        }
    }

    func testBool() {
        assertInlineSnapshot(of: true.recreatable(indent: 0), as: .lines) {
            """
            true
            """
        }
    }

    func testData() {
        let stringValue = "some-string"
        // swiftlint:disable:next force_unwrapping
        let data: Data = stringValue.data(using: .utf8)!
        assertInlineSnapshot(of: data.recreatable(indent: 0), as: .lines) {
            """
            Data(
                base64Encoded: "c29tZS1zdHJpbmc="
            )!
            """
        }
        XCTAssertEqual(
            // swiftlint:disable:next force_unwrapping
            String(bytes: Data(base64Encoded: "c29tZS1zdHJpbmc=")!, encoding: .utf8),
            stringValue
        )
    }

    func testEnum() {
        assertInlineSnapshot(of: MyEnum.simple.recreatable(indent: 0), as: .lines) {
            """
            .simple
            """
        }
        assertInlineSnapshot(of: MyEnum.associatedValue("foo-bar").recreatable(indent: 0), as: .lines) {
            """
            .associatedValue("foo-bar")
            """
        }
        assertInlineSnapshot(
            of: MyEnum.namedAssociatedValues(foo: "foo", bar: "bar").recreatable(indent: 0),
            as: .lines
        ) {
            """
            .namedAssociatedValues(
                foo: "foo",
                bar: "bar"
            )
            """
        }
    }

    func testStruct() {
        assertInlineSnapshot(
            of: MyStruct(
                foo: "foo",
                bar: [42, 4, 2],
                enumValue: .namedAssociatedValues(foo: "aa", bar: "bb"),
                json: nil
            ).recreatable(indent: 0),
            as: .lines
        ) {
            """
            MyStruct(
                foo: "foo",
                bar: [
                    42,
                    4,
                    2,
                ],
                enumValue: .namedAssociatedValues(
                    foo: "aa",
                    bar: "bb"
                )
            )
            """
        }
    }

    func testNesting() {
        assertInlineSnapshot(
            of: MyStruct(
                foo: "foo",
                bar: [42, 4, 2],
                enumValue: .structValue(
                    structValue: MyStruct(
                        foo: "foo",
                        bar: [333333],
                        enumValue: .associatedValue("why would you want this?"),
                        json: nil
                    )
                ),
                json: nil
            ).recreatable(indent: 0),
            as: .lines
        ) {
            """
            MyStruct(
                foo: "foo",
                bar: [
                    42,
                    4,
                    2,
                ],
                enumValue: .structValue(structValue: MyStruct(
                    foo: "foo",
                    bar: [333333],
                    enumValue: .associatedValue("why would you want this?")
                ))
            )
            """
        }
    }

    func testDictionary() {
        let stringDict: [String: Any] = [
            "string": "value",
            "int": 42,
            "double": 42.0,
            "bool": true,
            "array": [
                "foo",
                "bar",
                "baz",
            ],
            "dictionary": [
                "string": "value",
                "int": 42,
                "double": 42.0,
                "bool": true,
                "dictionary": [
                    "string": "value",
                    "int": 42,
                    "double": 42.0,
                    "bool": true,
                ],
            ],
        ]

        assertInlineSnapshot(of: stringDict.recreatable(indent: 0), as: .lines) {
            """
            [
                "array": [
                    "foo",
                    "bar",
                    "baz",
                ],
                "bool": true,
                "dictionary": [
                    "bool": true,
                    "dictionary": [
                        "bool": true,
                        "double": 42.0,
                        "int": 42,
                        "string": "value",
                    ],
                    "double": 42.0,
                    "int": 42,
                    "string": "value",
                ],
                "double": 42.0,
                "int": 42,
                "string": "value",
            ]
            """
        }
    }

    func testArray() {
        assertInlineSnapshot(of: ["foo", "bar", "baz"].recreatable(indent: 0), as: .lines) {
            """
            [
                "foo",
                "bar",
                "baz",
            ]
            """
        }
    }

    func testEmptyString() {
        assertInlineSnapshot(of: ["", "second", "first"].recreatable(indent: 0), as: .lines) {
            """
            [
                "",
                "second",
                "first",
            ]
            """
        }
    }

    func testRequestWithEmptyQueryDictionary() {
        assertInlineSnapshot(of: Request(query: [:]).recreatable(indent: 0), as: .lines) {
            """
            Request(query: [:])
            """
        }
    }

    func testEmptyStringInStruct() {
        assertInlineSnapshot(
            of: MyStruct(foo: nil, bar: [], enumValue: .simple, json: nil).recreatable(indent: 0),
            as: .lines
        ) {
            """
            MyStruct(
                bar: [],
                enumValue: .simple
            )
            """
        }
    }

    func testJSON() {
        let json: JSON = [
            "string": "value",
            "int": 42,
            "dictionary": [
                "double": 42.0,
                "bool": true,
                "array": [
                    "foo",
                    "bar",
                ],
                "nested": [
                    "query": true,
                ],
                "null": .null,
            ],
        ]

        assertInlineSnapshot(
            of: MyStruct(foo: nil, bar: [], enumValue: .simple, json: json).recreatable(indent: 0),
            as: .lines
        ) {
            """
            MyStruct(
                bar: [],
                enumValue: .simple,
                json: [
                    "dictionary": [
                        "array": [
                            "foo",
                            "bar",
                        ],
                        "bool": true,
                        "double": 42.0,
                        "nested": ["query": true],
                        "null": .null,
                    ],
                    "int": 42.0,
                    "string": "value",
                ]
            )
            """
        }

    }
}
