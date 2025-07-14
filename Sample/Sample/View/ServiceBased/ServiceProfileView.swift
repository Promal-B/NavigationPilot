//
//  ServiceProfileView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct ServiceProfileView: View {
    @EnvironmentObject var navigationService: NavigationService

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile (Service-Based)")
                .font(.title)

            Button("Logout") {
                navigationService.logout()
            }
            .buttonStyle(.bordered)
        }
        .pilotNavigationTitle("Profile")
    }
}
