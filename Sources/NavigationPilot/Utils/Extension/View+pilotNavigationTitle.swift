//
//  View+pilotNavigationTitle.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

extension View {
    public func pilotNavigationTitle(_ title: String) -> some View {
        return modifier(NavTitleModifier(title: title))
    }
}
