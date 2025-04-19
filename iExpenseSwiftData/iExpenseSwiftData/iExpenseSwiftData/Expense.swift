//
//  Expense.swift
//  iExpenseSwiftData
//
//  Created by Christopher Smith on 3/31/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id: UUID
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID, name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
