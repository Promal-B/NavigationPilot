//
//  ServiceSettingsView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct ServiceSettingsView: View {
    @EnvironmentObject var navigationService: NavigationService

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings (Service-Based)")
                .font(.title)

            Button("Back to Home") {
                navigationService.mainPilot.popTo(.home)
            }
            .buttonStyle(.bordered)
        }
        .pilotNavigationTitle("Settings")
    }
}
