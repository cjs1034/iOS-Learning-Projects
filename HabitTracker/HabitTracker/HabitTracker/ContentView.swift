//
//  ContentView.swift
//  HabitTracker
//
//  Created by Christopher Smith on 3/11/25.
//

import SwiftUI

//List of all activities
//Form to add activities (Title & Description)
//Tapping Habit > Detailed view w Description, plus running total of times complete, and button to increase
//Use Codable and UserDefaults to save data

struct Activity: Identifiable, Codable, Hashable {
    var id = UUID()
    var actName: String
    var actType: String
    var actDescription: String
    var actTotal: Int
}

//@Observable
class Habit: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Activity].self, from: savedHabits) {
                activities = decodedHabits
                return
            }
        }
        activities = []
    }
}

struct ContentView: View {
    @State private var habits = Habit()
    @State private var showingAddActivityView = false
    @State private var showingTrackHabitView = false
    @State private var selectedActivity: Activity?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    ForEach(habits.activities) { activity in
                        HStack {
//                            Button {
//                                selectedActivity = activity
//                                showingTrackHabitView = true
//                            } label: {
//                                Image(systemName: "app.badge.checkmark")
//                                    .frame(width: 20.0, height: 20.0) // Add a frame to ensure tappable area
//                            } //closing of Button
                            
                            Spacer()
                            
                            NavigationLink(destination: DetailedHabitView(activity: activity, habits: habits)) {
                                
                                VStack (alignment: .leading) {
                                    Text(activity.actName)
                                        .font(.headline)
                                    Text(activity.actType)
                                        .font(.callout)
                                } //closing of VStack
                                
                                .contentShape(Rectangle())
                                .frame(width: 100.0, height: 40.0)
                                .buttonStyle(PlainButtonStyle())
                                
                                Spacer()
                                    
                                Text("Completed: \(activity.actTotal)")
                                    .bold()
                                    .padding(.leading, 50.0)
                            } //closing of NavigationLink
                        } //closing of HStack
                        .swipeActions(edge: .leading) {
                            Button {
                                selectedActivity = activity
                                showingTrackHabitView = true
                            } label: {
                                Label("Complete", systemImage: "app.badge.checkmark")
                            }
                        }
                    } //closing of ForEach
                    .onDelete(perform: removeHabit)
                    .id(habits.activities)
                    
                } //closing of Section
            } //closing of List
            .navigationTitle("Habits")
            .toolbar {
                Button("Add Activity", systemImage: "plus") {
                    showingAddActivityView = true
                } //closing of Button
                .sheet(isPresented: $showingAddActivityView) {
                    AddActivityView(habits: $habits)
                } //closing of Alert
            } //closing of .toolbar
            
        } //closing of NavStack
        
        .alert("Habit Complete?", isPresented: $showingTrackHabitView, presenting: selectedActivity) { activity in
            Button("High Five") {
                increaseTotal(activity: activity)
                selectedActivity = nil //reset after use
            }
            Button("Reset") {
                resetTotal(activity: activity)
                selectedActivity = nil //reset after use
            }
            Button("Cancel", role: .cancel) {
                selectedActivity = nil //reset after use
            }
        } //closing of .alert
        .navigationDestination(for: Activity.self) { activity in
            DetailedHabitView(activity: activity, habits: habits)
        } //closing of navDestination
            
    } //closing of body:View
    
    func removeHabit(at offsets: IndexSet) {
        habits.activities.remove(atOffsets: offsets)
    } //closing of removeHabit
    
    func increaseTotal(activity: Activity) {
        if let index = habits.activities.firstIndex(where: { $0.id == activity.id }) {
            habits.activities[index].actTotal += 1
        }
    } //closing of increaseTotal
    
    func resetTotal(activity: Activity) {
        if let index = habits.activities.firstIndex(where: { $0.id == activity.id }) {
            habits.activities[index].actTotal = 0
        }
    } //closing of resetTotal
    
    } //closing of ContentView

#Preview {
    ContentView()
}
