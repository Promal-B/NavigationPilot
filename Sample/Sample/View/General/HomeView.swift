//
//  HomeView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct HomeView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to the Home Screen!")
                .font(.title)
                .padding()

            Button("Go to Profile") {
                pilot.push(.profile)
            }
            .buttonStyle(.borderedProminent)

            Button("Go to Settings") {
                pilot.push(.settings)
            }
            .buttonStyle(.borderedProminent)

            Button("Go to Login") {
                pilot.push(.login)
            }
            .buttonStyle(.borderedProminent)
        }
        .pilotNavigationTitle("Home")
    }
}
