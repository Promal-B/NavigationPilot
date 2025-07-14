//
//  view+pilotNavigationBarHidden.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

extension View {
    public func pilotNavigationBarHidden(_ hidden: Bool) -> some View {
        return modifier(NavHiddenModifier(isHidden: hidden))
    }
}
