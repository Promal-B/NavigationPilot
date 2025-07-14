//
//  NavigationStyleKey.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

private struct NavigationStyleKey: @preconcurrency EnvironmentKey {
    @MainActor
    static let defaultValue: NavigationStyle = NavigationStyle()
}

extension EnvironmentValues {
    var navigationStyle: NavigationStyle {
        get { self[NavigationStyleKey.self] }
        set { self[NavigationStyleKey.self] = newValue }
    }
}
