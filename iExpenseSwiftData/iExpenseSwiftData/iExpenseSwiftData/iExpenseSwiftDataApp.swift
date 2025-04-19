//
//  iExpenseSwiftDataApp.swift
//  iExpenseSwiftData
//
//  Created by Christopher Smith on 3/31/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
            .modelContainer(for: Expense.self)
    }
}
