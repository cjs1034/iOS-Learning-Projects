//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Christopher Smith on 3/12/25.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var actName = "Reading"
    @State private var actType = "Personal"
    @State private var actDescription = "Reading books. 15 minutes minimum"
    @State private var actTotal = 0
    
    let actTypes = ["Family", "Personal", "Career"]
    
    var habits: Habit
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Activity Name", text: $actName)
                
                Picker("Activity Type", selection: $actType) {
                    ForEach(actTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Activity Description", text: $actDescription)
                
                //Button here?
                
            }
            .navigationTitle("Add New Activity")
            
            Button("Cancel") {
                dismiss()
            }
            .toolbar {
                Button("Save") {
                    let habit = Activity(actName: actName, actType: actType, actDescription: actDescription, actTotal: actTotal)
                    habits.activities.append(habit)
                    dismiss()
                }
            }
            
        }
    }
}

#Preview {
    //AddActivityView(habits: Habit())
}
