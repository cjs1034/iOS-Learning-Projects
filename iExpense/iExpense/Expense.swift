//
//  Expense.swift
//  iExpense
//
//  Created by Christopher Smith on 3/31/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    //let types = ["Business", "Personal"]
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
