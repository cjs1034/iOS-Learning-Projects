//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Christopher Smith on 2/27/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
