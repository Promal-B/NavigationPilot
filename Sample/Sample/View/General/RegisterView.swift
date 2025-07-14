//
//  RegisterView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

struct RegisterView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.title)

            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Register") {
                // Simulate registration success
                pilot.popToRoot()
                pilot.push(.profile)
            }
            .buttonStyle(.borderedProminent)

            Button("Already have an account? Login") {
                pilot.pop() // Go back to login
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .pilotNavigationTitle("Register")
    }
}
