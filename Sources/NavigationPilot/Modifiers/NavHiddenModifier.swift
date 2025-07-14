//
//  NavHiddenModifier.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

struct NavHiddenModifier: ViewModifier {
    let isHidden: Bool

    @State private var id = UUID().uuidString
    @State private var initialValue: Bool = false

    @Environment(\.navigationStyle) var navStyle

    func body(content: Content) -> some View {
        // Handle isHidden changes after onAppear
        if navStyle.isHiddenOwner == id && navStyle.isHidden != isHidden {
            DispatchQueue.main.async {
                navStyle.isHidden = isHidden
            }
        }

        return content
            .onAppear {
                initialValue = navStyle.isHidden
                navStyle.isHidden = isHidden
                navStyle.isHiddenOwner = id
            }
            .onDisappear {
                if navStyle.isHiddenOwner == id {
                    navStyle.isHidden = initialValue
                    navStyle.isHiddenOwner = ""
                }
            }
    }
}
