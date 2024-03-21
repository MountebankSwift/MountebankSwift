import XCTest
@testable import MountebankSwift

final class RecreatableTests: XCTestCase {
    struct MyStruct: Recreatable {
        let foo: String
        let bar: [Int]
        let enumValue: MyEnum

        public func swiftString(depth: Int) -> String {
            structSwiftString(depth: depth, [
                ("foo", foo),
                ("bar", bar),
                ("enumValue", enumValue)
            ])
        }
    }

    indirect enum MyEnum: Recreatable {
        case simple
        case associatedValue(String)
        case namedAssociatedValues(foo: String, bar: String)
        case structValue(structValue: MyStruct)

        public func swiftString(depth: Int) -> String {
            switch self {
            case .simple:
                return enumSwiftString(depth: depth)
            case .associatedValue(let string):
                return enumSwiftString(depth: depth, [string])
            case .namedAssociatedValues(let foo, let bar):
                return enumSwiftString(depth: depth, [("foo", foo), ("bar", bar)])
            case .structValue(let structValue):
                return enumSwiftString(depth: depth, [("structValue", structValue)])
            }
        }
    }

    func testString() {
        assertRecreatable("some string value", "\"some string value\"")
    }

    func testInt() {
        assertRecreatable(42, "42")
    }

    func testDouble() {
        assertRecreatable(42.0, "42.0")
    }

    func testBool() {
        assertRecreatable(true, "true")
    }

    func testEnum() {
        assertRecreatable(MyEnum.simple, ".simple")
        assertRecreatable(
            MyEnum.associatedValue("foo-bar"),
            """
            .associatedValue(
                "foo-bar"
            )
            """
        )
        assertRecreatable(
            MyEnum.namedAssociatedValues(foo: "foo", bar: "bar"),
            """
            .namedAssociatedValues(
                foo: "foo",
                bar: "bar"
            )
            """
        )
    }

    func testStruct() {
        assertRecreatable(
            MyStruct(foo: "foo", bar: [42, 4, 2], enumValue: .namedAssociatedValues(foo: "aa", bar: "bb")),
            """
            MyStruct(
                foo: "foo",
                bar: [
                    42,
                    4,
                    2
                ],
                enumValue: .namedAssociatedValues(
                    foo: "aa",
                    bar: "bb"
                )
            )
            """
        )
    }

    func testNesting() {
        assertRecreatable(
            MyStruct(
                foo: "foo",
                bar: [42, 4, 2],
                enumValue: .structValue(
                    structValue: MyStruct(
                        foo: "foo",
                        bar: [333333],
                        enumValue: .associatedValue("why would you want this?")
                    )
                )
            ),
            """
            MyStruct(
                foo: "foo",
                bar: [
                    42,
                    4,
                    2
                ],
                enumValue: .structValue(
                    structValue: MyStruct(
                        foo: "foo",
                        bar: [
                            333333
                        ],
                        enumValue: .associatedValue(
                            "why would you want this?"
                        )
                    )
                )
            )
            """
        )
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
                "baz"
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
                ]
            ]
        ]

        assertRecreatable(
            stringDict,
            """
            [
                "array": [
                    "foo",
                    "bar",
                    "baz"
                ],
                "bool": true,
                "dictionary": [
                    "bool": true,
                    "dictionary": [
                        "bool": true,
                        "double": 42.0,
                        "int": 42,
                        "string": "value"
                    ],
                    "double": 42.0,
                    "int": 42,
                    "string": "value"
                ],
                "double": 42.0,
                "int": 42,
                "string": "value"
            ]
            """
        )
    }

    func testArray() {
        assertRecreatable(
            ["foo", "bar", "baz"],
            """
            [
                "foo",
                "bar",
                "baz"
            ]
            """
        )
    }

    func assertRecreatable(_ value: Recreatable, _ expectedResult: String, description: String? = nil, line: UInt = #line) {
        if let description {
            XCTAssertEqual(value.swiftString(depth: 0), expectedResult, description, line: line)
        } else {
            XCTAssertEqual(value.swiftString(depth: 0), expectedResult, line: line)
        }
    }
}
