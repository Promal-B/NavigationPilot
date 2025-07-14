//
//  ProfileView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct ProfileView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile Screen")
                .font(.title)

            Text("User: John Doe")
                .font(.headline)

            Button("View Details") {
                pilot.push(.details)
            }
            .buttonStyle(.borderedProminent)

            Button("Go to Settings") {
                pilot.push(.settings)
            }
            .buttonStyle(.borderedProminent)

            Button("Back to Home") {
                pilot.popTo(.home)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .pilotNavigationTitle("Profile")
    }
}
