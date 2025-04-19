//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Christopher Smith on 3/20/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
