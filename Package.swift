// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationPilot",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NavigationPilot",
            targets: ["NavigationPilot"]),
    ],
    dependencies: [
        .package(url: "https://github.com/canopas/UIPilot.git", .upToNextMajor(from: "2.0.2")),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.58.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NavigationPilot",
            dependencies: [
                .product(name: "UIPilot", package: "uipilot"),
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        )
    ]
)
