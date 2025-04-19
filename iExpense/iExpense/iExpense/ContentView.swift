//
//  ContentView.swift
//  iExpense
//
//  Created by Christopher Smith on 2/27/25.
//

import SwiftData
import SwiftUI

//struct ExpenseItem: Identifiable, Codable {
//    var id = UUID()
//    let name: String
//    let type: String
//    let amount: Double
//}
//
//@Observable
//class Expenses {
//    var items = [ExpenseItem]() {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                items = decodedItems
//                return
//            }
//        }
//
//        items = []
//    }
//}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink("Add Expense") {
                    // showingAddExpense = true
                    AddView(expenses: expenses)
                }
                .padding(.leading)
            
                Spacer()
            }
            
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                var textColor: Color {
                                    if item.amount < 10 {
                                        return .green
                                    } else if item.amount < 100 {
                                        return .blue
                                    } else {
                                        return .red
                                    }
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(textColor)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business Expenses") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                var textColor: Color {
                                    if item.amount < 10 {
                                        return .green
                                    } else if item.amount < 100 {
                                        return .blue
                                    } else {
                                        return .red
                                    }
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(textColor)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
//            .toolbar { //Removed due to added NavigationLink at top
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
//                
//                .sheet(isPresented: $showingAddExpense) {
//                    AddView(expenses: expenses)
//                }
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
