//
//  AddView.swift
//  iExpense
//
//  Created by Christopher Smith on 3/1/25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Expense Name"
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
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
            //.navigationTitle($name)
            //.navigationBarTitleDisplayMode(.inline)
            
            Button("Cancel") {
                dismiss()
            }
            
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
