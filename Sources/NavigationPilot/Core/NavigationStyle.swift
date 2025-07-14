//
//  NavigationStyle.swift
//  NavigationPilot
//
//  Created by Starconnect on 7/14/25.
//

import Foundation

@MainActor
class NavigationStyle: ObservableObject {
    @Published var isHidden = false
    var isHiddenOwner: String = ""

    @Published var title = ""
    var titleOwner: String = ""
}
