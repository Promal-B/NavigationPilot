//
//  Logger.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import Foundation

protocol Logger {
    func log(_ value: String)
}

struct DebugLog: Logger {
    func log(_ value: String) {
        print(value)
    }
}

struct EmptyLog: Logger {
    func log(_ value: String) {
        // No-op
    }
}
