//
//  NavigationStyle.swift
//  SwiftPilot
//
//  Created by Starconnect on 7/13/25.
//

import SwiftUI
import Combine

// MARK: - NavigationPilot
public class NavigationPilot<T: Equatable & Hashable>: ObservableObject {

    private let logger: Logger

    @Published public private(set) var routes: [T] = []
    @Published internal var path: [T] = []

    public init(initial: T? = nil, debug: Bool = false) {
        logger = debug ? DebugLog() : EmptyLog()
        logger.log("NavigationPilot - Pilot Initialized.")

        if let initial = initial {
            push(initial)
        }
    }

    public func push(_ route: T) {
        logger.log("NavigationPilot - Pushing \(route) route.")
        routes.append(route)

        // For NavigationStack, we need to build the path excluding the root
        if routes.count > 1 {
            path = Array(routes.dropFirst())
        }
    }

    public func pop(animated: Bool = true) {
        guard !routes.isEmpty else { return }

        let popped = routes.removeLast()
        logger.log("NavigationPilot - \(popped) route popped.")

        // Update path to exclude the root
        if routes.count > 1 {
            path = Array(routes.dropFirst())
        } else {
            path = []
        }
    }

    public func popTo(_ route: T, inclusive: Bool = false, animated: Bool = true) {
        logger.log("NavigationPilot: Popping to route \(route).")

        if routes.isEmpty {
            logger.log("NavigationPilot - Path is empty.")
            return
        }

        guard var found = routes.lastIndex(where: { $0 == route }) else {
            logger.log("NavigationPilot - Route not found.")
            return
        }

        if !inclusive {
            found += 1
        }

        let numToPop = (found..<routes.endIndex).count
        logger.log("NavigationPilot - Popping \(numToPop) routes")

        // Remove from routes array
        routes.removeLast(numToPop)

        // Update path to exclude the root
        if routes.count > 1 {
            path = Array(routes.dropFirst())
        } else {
            path = []
        }
    }

    public func popToRoot(animated: Bool = true) {
        logger.log("NavigationPilot - Popping to root.")
        let firstRoute = routes.first
        routes.removeAll()
        path = []

        // Keep the first route as root
        if let firstRoute = firstRoute {
            routes.append(firstRoute)
        }
    }

    // Handle system-initiated pops (back button, swipe gesture)
    internal func onSystemPop() {
        guard !routes.isEmpty else { return }

        let popped = routes.removeLast()
        logger.log("NavigationPilot - \(popped) route popped by system")
    }
}
