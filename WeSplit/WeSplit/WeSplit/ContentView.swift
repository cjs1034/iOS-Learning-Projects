//
//  ContentView.swift
//  WeSplit
//
//  Created by Christopher Smith on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    //let tipPercentages = [10, 15, 20, 25, 0]
    
    var check: (grandTotal: Double, amountPerPerson: Double) {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return (grandTotal, amountPerPerson)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)

                }
                
                //Section("How much do you want to tip?") {
                //    Picker("Tip percentage", selection: $tipPercentage) {
                //        ForEach(tipPercentages, id: \.self) {
                //            Text($0, format: .percent)
                //        }
                //    }
                //    .pickerStyle(.segmented)
                //}
                
                Section("Total Bill") {
                    Text(check.grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage < 10 ? .red : .primary)
                }
                
                Section("Amount per person") {
                    Text(check.amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
            }
            .navigationTitle("WeSplit")
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
