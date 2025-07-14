//
//  ServiceLoginView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct ServiceLoginView: View {
    @EnvironmentObject var navigationService: NavigationService

    var body: some View {
        VStack(spacing: 20) {
            Text("Login (Service-Based)")
                .font(.title)

            Button("Login") {
                navigationService.login()
            }
            .buttonStyle(.borderedProminent)
        }
        .pilotNavigationTitle("Login")
    }
}
