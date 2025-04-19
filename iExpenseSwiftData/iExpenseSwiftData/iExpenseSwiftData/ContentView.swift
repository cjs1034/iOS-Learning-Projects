//
//  ContentView.swift
//  iExpenseSwiftData
//
//  Created by Christopher Smith on 3/31/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var filteredTypes = ["All", "Business", "Personal"]
    @State private var filter = "All"
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount),
    ]

    var body: some View {
        NavigationStack {
            ExpensesView(filter: filter, sortOrder: sortOrder) 
            
            .navigationTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView()
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
                Menu("Filter") {
                    Picker("Filter", selection: $filter) {
                        ForEach(filteredTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount),
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name),
                            ])
                    }
                }
            }
        }
    }
}
    
#Preview {
    ContentView()
        .modelContainer(for: Expense.self)
}
