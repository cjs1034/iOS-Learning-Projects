//
//  AddExpenseView.swift
//  iExpenseSwiftData
//
//  Created by Christopher Smith on 4/1/25.
//

import SwiftData
import SwiftUI

struct AddExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var expenses: [Expense]
    
    @State private var id: UUID = UUID()
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            
            Button("Cancel") {
                dismiss()
            }
            .toolbar {
                Button("Save") {
                    let newExpense = Expense(id: id, name: name, type: type, amount: amount)
                    modelContext.insert(newExpense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
        .modelContainer(for: Expense.self)
}
