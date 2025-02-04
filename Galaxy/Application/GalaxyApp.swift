//
//  GalaxyApp.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import SwiftUI

@main
struct GalaxyApp: App {
    /// Main scene of the app
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GalaxyHomeView()
            }
        }
    }
}
