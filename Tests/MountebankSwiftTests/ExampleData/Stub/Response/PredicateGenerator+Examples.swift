import Foundation
import MountebankSwift

extension PredicateGenerator {
    enum Examples {
        static let all: [Example] = [
            simple,
            nestedFields,
            advanced,
            jsonPath,
            xPath,
            inject
        ]

        static let simple = Example(
            value: PredicateGenerator.matches(
                fields: [
                    "path": true,
                    "method": true
                ],
                caseSensitive: true
            ),
            json: [
                "matches": [
                    "path": true,
                    "method": true
                ],
                "caseSensitive": true,
            ]
        )

        static let nestedFields = Example(
            value: PredicateGenerator.matches(
                fields: [
                    "query": [ "productId": true, "category": true ],
                ]
            ),
            json: [
                "matches": [
                    "query": [ "productId": true, "category": true ],
                ]
            ]
        )

        static let advanced = Example(
            value: PredicateGenerator.matches(
                fields: [
                    "path": true,
                    "method": true,
                    "query": true,
                ],
                predicateOperator: .deepEquals,
                caseSensitive: true,
                except: "!$",
                ignore: [
                    "query": "startDate"
                ]
            ),
            json: [
                "matches": [
                    "path": true,
                    "method": true,
                    "query": true,
                ],
                "predicateOperator": "deepEquals",
                "except": "!$",
                "caseSensitive": true,
                "ignore": [
                    "query": "startDate"
                ]
            ]
        )

        static let jsonPath = Example(
            value: PredicateGenerator.matches(
                fields: [ "body": true ],
                jsonPath: JSONPath(selector: "$..number")
            ),
            json: [
                "matches": [ "body": true ],
                "jsonpath": ["selector": "$..number"]
            ]
        )

        static let xPath = Example(
            value: PredicateGenerator.matches(
                fields: [ "body": true ],
                xPath: XPath(selector: "//number")
            ),
            json: [
                "matches": [ "body": true ],
                "xpath": ["selector": "//number"]
            ]
        )

        static let inject = Example(
            value: PredicateGenerator.inject("""
                function (config) {
                    const predicate = {
                        exists: {
                            headers: {
                                'X-Transaction-Id': false
                            }
                        }
                    };
                    if (config.request.headers['X-Transaction-Id']) {
                        config.logger.debug('Requiring X-Transaction-Id header to exist in predicate');
                        predicate.exists.headers['X-Transaction-Id'] = true;
                    }
                    return [predicate];
                }
            """),
            json: [
                "inject": """
                function (config) {
                    const predicate = {
                        exists: {
                            headers: {
                                'X-Transaction-Id': false
                            }
                        }
                    };
                    if (config.request.headers['X-Transaction-Id']) {
                        config.logger.debug('Requiring X-Transaction-Id header to exist in predicate');
                        predicate.exists.headers['X-Transaction-Id'] = true;
                    }
                    return [predicate];
                }
            """
            ]
        )
    }
}
