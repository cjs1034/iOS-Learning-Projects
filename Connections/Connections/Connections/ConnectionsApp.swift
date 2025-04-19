//
//  ConnectionsApp.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import SwiftUI

@main
struct ConnectionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
