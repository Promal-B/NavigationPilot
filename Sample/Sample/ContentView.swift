//
//  ContentView.swift
//  Sample
//
//  Created by Starconnect on 7/14/25.
//

import SwiftUI
import NavigationPilot

// MARK: - Step 1: Define Your Routes
enum AppRoute: String, CaseIterable, Equatable, Hashable {
    case home = "Home"
    case profile = "Profile"
    case settings = "Settings"
    case details = "Details"
    case login = "Login"
    case register = "Register"
}

// MARK: - General Setup
struct ContentView: View {
    // MARK: - Step 2: Create the navigation pilot with initial route
    @StateObject private var pilot = NavigationPilot<AppRoute>(initial: .home, debug: true)

    var body: some View {
        // MARK: - Step 3: using NavigationPilotHost to map views with AppRoute
        NavigationPilotHost(pilot) { route in
            routeView(for: route)
        }
    }
    // Route mapping function
    // MARK: - Step 4: access NavigationPilot from Environment and route using that
    ///  ```
    ///  @EnvironmentObject var pilot: NavigationPilot<AppRoute>
    ///  ```
    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        case .details:
            DetailsView()
        case .login:
            LoginView()
        case .register:
            RegisterView()
        }
    }
}

// Example 1: Custom Route with Associated Values
enum CustomRoute: Equatable, Hashable {
    case home
    case userProfile(userId: String)
    case productDetail(productId: Int)
    case settings
}

struct CustomRouteExample: View {
    @StateObject private var pilot = NavigationPilot<CustomRoute>(initial: .home)

    var body: some View {
        NavigationPilotHost(pilot) { route in
            switch route {
            case .home:
                CustomHomeView()
            case .userProfile(let userId):
                Text("User Profile: \(userId)")
                    .pilotNavigationTitle("User \(userId)")
            case .productDetail(let productId):
                Text("Product Detail: \(productId)")
                    .pilotNavigationTitle("Product \(productId)")
            case .settings:
                Text("Settings")
                    .pilotNavigationTitle("Settings")
            }
        }
    }
}

struct CustomHomeView: View {
    @EnvironmentObject var pilot: NavigationPilot<CustomRoute>

    var body: some View {
        VStack(spacing: 20) {
            Button("View User Profile") {
                pilot.push(.userProfile(userId: "12345"))
            }

            Button("View Product") {
                pilot.push(.productDetail(productId: 67890))
            }

            Button("Settings") {
                pilot.push(.settings)
            }
        }
        .pilotNavigationTitle("Home")
    }
}

// Example 2: Multiple Navigation Pilots in Different Parts of App
struct TabViewExample: View {
    @StateObject private var mainPilot = NavigationPilot<AppRoute>(initial: .home)
    @StateObject private var profilePilot = NavigationPilot<AppRoute>(initial: .profile)

    var body: some View {
        TabView {
            NavigationPilotHost(mainPilot) { route in
                routeView(for: route)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationPilotHost(profilePilot) { route in
                routeView(for: route)
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }

    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        case .details:
            DetailsView()
        case .login:
            LoginView()
        case .register:
            RegisterView()
        }
    }
}

// Example 3: Navigation Service for Complex Apps
class NavigationService: ObservableObject {
    @Published var mainPilot = NavigationPilot<AppRoute>(initial: .home, debug: true)
    @Published var isAuthenticated = false

    func login() {
        isAuthenticated = true
        mainPilot.popToRoot()
        mainPilot.push(.profile)
    }

    func logout() {
        isAuthenticated = false
        mainPilot.popToRoot()
    }

    func navigateToSettings() {
        // Navigate to settings from anywhere
        mainPilot.push(.settings)
    }
}

struct ServiceBasedNavigationExample: View {
    @StateObject private var navigationService = NavigationService()

    var body: some View {
        NavigationPilotHost(navigationService.mainPilot) { route in
            routeView(for: route)
        }
        .environmentObject(navigationService)
    }

    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            ServiceHomeView()
        case .profile:
            ServiceProfileView()
        case .settings:
            ServiceSettingsView()
        case .details:
            DetailsView()
        case .login:
            ServiceLoginView()
        case .register:
            RegisterView()
        }
    }
}

#Preview {
    ContentView()
}
