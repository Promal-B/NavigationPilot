//
//  SettingsView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct SettingsView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>
    @State private var hideNavBar = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title)

            Toggle("Hide Navigation Bar", isOn: $hideNavBar)
                .padding()

            Button("Go to Profile") {
                pilot.push(.profile)
            }
            .buttonStyle(.borderedProminent)

            Button("Pop Back") {
                pilot.pop()
            }
            .buttonStyle(.bordered)

            Button("Pop to Root") {
                pilot.popToRoot()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .pilotNavigationTitle("Settings")
        .pilotNavigationBarHidden(hideNavBar)
    }
}
