//
//  ServiceHomeView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct ServiceHomeView: View {
    @EnvironmentObject var navigationService: NavigationService

    var body: some View {
        VStack(spacing: 20) {
            Text("Service-Based Navigation")
                .font(.title)

            if navigationService.isAuthenticated {
                Button("Go to Profile") {
                    navigationService.mainPilot.push(.profile)
                }
                .buttonStyle(.borderedProminent)

                Button("Logout") {
                    navigationService.logout()
                }
                .buttonStyle(.bordered)
            } else {
                Button("Login") {
                    navigationService.mainPilot.push(.login)
                }
                .buttonStyle(.borderedProminent)
            }

            Button("Settings") {
                navigationService.navigateToSettings()
            }
            .buttonStyle(.borderedProminent)
        }
        .pilotNavigationTitle("Home")
    }
}
