//
//  DetailedHabitView.swift
//  HabitTracker
//
//  Created by Christopher Smith on 3/14/25.
//

import SwiftUI

struct DetailedHabitView: View {
    var activity: Activity
    var habits: Habit
    
    @State private var actNotes: String = ""

    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(activity.actName)
                            .font(.title)
                            .fontWeight(.semibold)
                            
                        Text("(\(activity.actType))")
                            .font(.title)
                    }
                    .padding(.bottom, 10)
                    Text(activity.actDescription)
                        .font(.title3)
                        .padding(.bottom, 10)
                    Text("Completed: \(activity.actTotal)")
                        .font(.title3)
                        .fontWeight(.black)
                        .foregroundColor(Color.blue)
                    
                    TextField("Notes:", text: $actNotes)
                    
                    Spacer()
                }
                .padding(.leading)
                .navigationTitle("Habit Details")
                
                Spacer()
            }
        }
    }
}

#Preview {
    DetailedHabitView(activity: Activity(actName: "Reading", actType: "Personal", actDescription: "Read for 15 minutes", actTotal: 5), habits: Habit())
}
