//
//  ExpensesView.swift
//  iExpenseSwiftData
//
//  Created by Christopher Smith on 4/1/25.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Query var expenses: [Expense]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.type)
                    }
                    Spacer()
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .onDelete(perform: deleteExpenses)
        }
    }
        
    init(filter: String, sortOrder: [SortDescriptor<Expense>]) {
        if filter == "All" {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Business" || expense.type == "Personal"
            }, sort: sortOrder)
        } else if filter == "Business" {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Business"
            }, sort: sortOrder)
        } else if filter == "Personal" {
            _expenses = Query(filter: #Predicate<Expense> { expense in
                expense.type == "Personal"
            }, sort: sortOrder)
        }
    }

    func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(filter: "Personal", sortOrder: [SortDescriptor(\Expense.amount)])
        .modelContainer(for: Expense.self)
}
