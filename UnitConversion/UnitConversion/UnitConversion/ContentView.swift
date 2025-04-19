//
//  ContentView.swift
//  UnitConversion
//
//  Created by Christopher Smith on 2/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var initialAmount = 0.0
    @State private var initialUnit = "oz"
    @State private var finalUnit = "cups"
    @FocusState private var amountIsFocused: Bool
    
    let initialUnits = ["tsp", "tbsp", "cups", "oz", "ml"]
    let finalUnits = ["tsp", "tbsp", "cups", "oz", "ml"]
    
    var finalAmount: Double {
        var cups = 0.0
        
        if initialUnit == "tsp" {
            cups = initialAmount / 48
        } else if initialUnit == "tbsp" {
            cups = initialAmount / 16
        } else if initialUnit == "oz" {
            cups = initialAmount / 8
        } else if initialUnit == "ml" {
            cups = initialAmount / 240
        } else {
            cups = initialAmount
        }
        
        if finalUnit == "tsp" {
            let finalAmount = cups * 48
            return finalAmount
        } else if finalUnit == "tbsp" {
            let finalAmount = cups * 16
            return finalAmount
        } else if finalUnit == "oz" {
            let finalAmount = cups * 8
            return finalAmount
        } else if finalUnit == "ml" {
            let finalAmount = cups * 240
            return finalAmount
        } else {
            let finalAmount = cups
            return finalAmount
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Original Amount") {
                    Picker("Original Units", selection: $initialUnit) {
                        ForEach(initialUnits, id: \.self) { Text($0)}
                    }
                    
                    TextField("Amount", value: $initialAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                }
                
                Section("Converted Amount") {
                    Picker("Converted Units", selection: $finalUnit) {
                        ForEach(finalUnits, id: \.self) { Text($0)}
                    }
                    
                    Text("\(finalAmount.formatted())")
                }
            }
            .navigationTitle("Conversion Calculator")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
