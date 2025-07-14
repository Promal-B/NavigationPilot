//
//  NavTitleModifier.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI

struct NavTitleModifier: ViewModifier {
    let title: String

    @State private var id = UUID().uuidString
    @State private var initialValue: String = ""

    @Environment(\.navigationStyle) var navStyle

    init(title: String) {
        self.title = title
    }

    func body(content: Content) -> some View {
        // Handle title changes after onAppear
        if navStyle.titleOwner == id && navStyle.title != title {
            DispatchQueue.main.async {
                navStyle.title = title
            }
        }

        return content
            .onAppear {
                initialValue = navStyle.title
                navStyle.title = title
                navStyle.titleOwner = id
            }
            .onDisappear {
                if navStyle.titleOwner == id {
                    navStyle.title = initialValue
                    navStyle.titleOwner = ""
                }
            }
    }
}
