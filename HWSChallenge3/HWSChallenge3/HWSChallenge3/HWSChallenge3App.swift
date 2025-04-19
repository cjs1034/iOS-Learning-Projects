//
//  HWSChallenge3App.swift
//  HWSChallenge3
//
//  Created by Christopher Smith on 4/2/25.
//

import SwiftData
import SwiftUI

@main
struct HWSChallenge3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
        .modelContainer(for: Friend.self)
    }
}
