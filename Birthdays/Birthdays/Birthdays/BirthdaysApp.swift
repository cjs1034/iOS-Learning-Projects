//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Christopher Smith on 1/13/25.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
