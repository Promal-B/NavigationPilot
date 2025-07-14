//
//  NavigationPilotHost.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

@available(iOS 16.0, *)
public struct NavigationPilotHost<T: Equatable & Hashable, Screen: View>: View {

    @StateObject private var navigationStyle = NavigationStyle()
    @ObservedObject private var pilot: NavigationPilot<T>

    private let routeMap: (T) -> Screen

    public init(_ pilot: NavigationPilot<T>, @ViewBuilder _ routeMap: @escaping (T) -> Screen) {
        self.pilot = pilot
        self.routeMap = routeMap
    }

    public var body: some View {
        NavigationStack(path: $pilot.path) {
            // Root view - we need to handle the case where there might be an initial route
            if let firstRoute = pilot.routes.first {
                routeMap(firstRoute)
                    .navigationDestination(for: T.self) { route in
                        routeMap(route)
                    }
            } else {
                // Empty root view if no initial route
                EmptyView()
                    .navigationDestination(for: T.self) { route in
                        routeMap(route)
                    }
            }
        }
        .navigationTitle(navigationStyle.title)
        .navigationBarHidden(navigationStyle.isHidden)
        .environmentObject(pilot)
        .environment(\.navigationStyle, navigationStyle)
        .onReceive(pilot.$path) { newPath in
            // Sync routes with path changes (handles system back navigation)
            let expectedPathCount = max(0, pilot.routes.count - 1) // Path excludes root
            let actualPathCount = newPath.count

            if actualPathCount < expectedPathCount {
                // System pop occurred
                let difference = expectedPathCount - actualPathCount
                for _ in 0..<difference {
                    pilot.onSystemPop()
                }

                // Update path to match routes
                if pilot.routes.count > 1 {
                    pilot.path = Array(pilot.routes.dropFirst())
                } else {
                    pilot.path = []
                }
            }
        }
    }
}
