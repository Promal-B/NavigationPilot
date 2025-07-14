# NavigationPilot

NavigationPilot is a powerful and flexible navigation library for SwiftUI, designed to simplify complex navigation flows with a clean and declarative API.

## Features

- **Declarative Routing:** Define your navigation routes using enums for type-safe and readable navigation.
- **Centralized Navigation Logic:** Manage your navigation stack from a single source of truth.
- **Support for Associated Values:** Pass data between views with ease using routes with associated values.
- **Multiple Navigation Stacks:** Effortlessly manage independent navigation flows in different parts of your app (e.g., TabViews).
- **Customizable Navigation Bar:** Easily set custom navigation titles and control the visibility of the navigation bar.
- **Complex Flow Management:** Integrates seamlessly with a `NavigationService` for handling complex navigation logic, such as authentication flows.
- **Debugging Support:** Built-in logging to help you debug your navigation stack.

## Installation

You can add NavigationPilot to your project using Swift Package Manager.

1. In Xcode, open your project and navigate to **File > Add Packages...**
2. Paste the repository URL: `https://github.com/your-username/NavigationPilot.git`
3. Select the package and add it to your project.

## Getting Started

### Step 1: Define Your Routes

Create an enum that defines all the possible navigation destinations in your app.

```swift
import NavigationPilot

enum AppRoute: String, CaseIterable, Equatable, Hashable {
    case home
    case profile
    case settings
    case details
}
```

### Step 2: Create the NavigationPilot

In your root view, create an instance of `NavigationPilot` and pass the initial route.

```swift
import SwiftUI
import NavigationPilot

struct ContentView: View {
    @StateObject private var pilot = NavigationPilot<AppRoute>(initial: .home)

    var body: some View {
        // ...
    }
}
```
ß
### Step 3: Set up the NavigationPilotHost

Use `NavigationPilotHost` to map your routes to their corresponding views.

```swift
struct ContentView: View {
    @StateObject private var pilot = NavigationPilot<AppRoute>(initial: .home)

    var body: some View {
        NavigationPilotHost(pilot) { route in
            routeView(for: route)
        }
    }

    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView()ß
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        case .details:
            DetailsView()
        }
    }
}
```

### Step 4: Navigate Between Views

To navigate from a view, access the `NavigationPilot` from the environment and use its navigation methods.

```swift
struct HomeView: View {
    @EnvironmentObject var pilot: NavigationPilot<AppRoute>

    var body: some View {
        VStack {
            Button("Go to Profile") {
                pilot.push(.profile)
            }
        }
        .pilotNavigationTitle("Home")
    }
}
```

## Advanced Usage

### Routes with Associated Values

For passing data between views, you can define routes with associated values.

```swift
enum CustomRoute: Equatable, Hashable {
    case home
    case userProfile(userId: String)
}

// Pushing a route with an associated value
pilot.push(.userProfile(userId: "12345"))

// Handling the route in the host
NavigationPilotHost(pilot) { route in
    switch route {
    case .home:
        HomeView()
    case .userProfile(let userId):
        UserProfileView(userId: userId)
    }
}
```

### Multiple Navigation Pilots

You can use multiple `NavigationPilot` instances to manage separate navigation stacks, for example, in a `TabView`.

```swift
struct AppTabView: View {
    @StateObject private var mainPilot = NavigationPilot<AppRoute>(initial: .home)
    @StateObject private var profilePilot = NavigationPilot<AppRoute>(initial: .profile)

    var body: some View {
        TabView {
            NavigationPilotHost(mainPilot) { route in
                // ...
            }
            .tabItem { Label("Home", systemImage: "house") }

            NavigationPilotHost(profilePilot) { route in
                // ...
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}
```

### Using a Navigation Service

For more complex scenarios, such as managing authentication flows, you can encapsulate your navigation logic in a `NavigationService`.

```swift
class NavigationService: ObservableObject {
    @Published var mainPilot = NavigationPilot<AppRoute>(initial: .home)
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
}

struct AppView: View {
    @StateObject private var navigationService = NavigationService()

    var body: some View {
        NavigationPilotHost(navigationService.mainPilot) { route in
            // ...
        }
        .environmentObject(navigationService)
    }
}
```

## API Reference

### NavigationPilot

The main object for managing the navigation stack.

- `init(initial: R, debug: Bool = false)`
- `push(_ route: R)`
- `pop()`
- `popToRoot()`

### NavigationPilotHost

A view that hosts the navigation stack and maps routes to views.

- `init(_ pilot: NavigationPilot<R>, _ content: @escaping (R) -> V)`

### Modifiers

- `.pilotNavigationTitle(_ title: String)`: Sets the title of the navigation bar.
- `.pilotNavigationBarHidden(_ hidden: Bool)`: Hides or shows the navigation bar.

## Example

For a complete example, please see the `Sample` directory in this package.
