//
//  Mountebank.swift
//
//  Created by Tieme van Veen on 12/05/2023.
//
import Foundation

public struct Mountebank {
    private let host: Host
    private let port: Int
    private var mountebankURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    public init(host: Host = .localhost, port: Int = 2525) {
        self.host = host
        self.port = port
    }
}
