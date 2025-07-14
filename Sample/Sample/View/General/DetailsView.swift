//
//  DetailsView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct DetailsView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Details Screen")
                .font(.title)

            Text("This is a detailed view with more information.")
                .multilineTextAlignment(.center)
                .padding()

            Button("Go Deeper (Another Details)") {
                pilot.push(.details)
            }
            .buttonStyle(.borderedProminent)

            Button("Back to Profile") {
                pilot.popTo(.profile)
            }
            .buttonStyle(.bordered)

            Button("Back to Home") {
                pilot.popTo(.home)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .pilotNavigationTitle("Details")
    }
}
