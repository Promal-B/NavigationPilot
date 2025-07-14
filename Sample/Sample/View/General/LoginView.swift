//
//  LoginView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct LoginView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title)

            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                // Simulate login success
                pilot.popToRoot()
                pilot.push(.profile)
            }
            .buttonStyle(.borderedProminent)

            Button("Don't have an account? Register") {
                pilot.push(.register)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .pilotNavigationTitle("Login")
    }
}
