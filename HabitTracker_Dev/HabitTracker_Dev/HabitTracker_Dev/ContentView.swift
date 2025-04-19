//
//  ContentView.swift
//  HabitTracker_Dev
//
//  Created by Christopher Smith on 3/16/25.
//

import SwiftUI

//List of all activities
//Form to add activities (Title & Description)
//Tapping Habit > Detailed view w Description, plus running total of times complete, and button to increase
//Use Codable and UserDefaults to save data

struct Activity: Identifiable, Hashable {
    var id = UUID()
    var actName: String
}

//@Observable
class Habit: ObservableObject {
    var activities = [Activity]()

    init() {
        activities = [
            Activity(actName: "act 0"),
            Activity(actName: "act 1"),
            Activity(actName: "act 2")
        ]
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
                            Button {
                                selectedActivity = activity
                                showingTrackHabitView = true
                            } label: {
                                Image(systemName: "app.badge.checkmark")
                                    .frame(width: 20.0, height: 20.0) // Add a frame to ensure tappable area
                            } //closing of Button

                            Spacer()

                            NavigationLink(destination: DetailedHabitView(activity: activity, habits: habits)) {

                                VStack (alignment: .leading) {
                                    Text(activity.actName)
                                        .font(.headline)
                                    Text("act type")
                                        .font(.callout)
                                } //closing of VStack

                                .contentShape(Rectangle())
                                .frame(width: 100.0, height: 40.0)
                                .buttonStyle(PlainButtonStyle())

                                Spacer()

                                Text("Completed:")
                                    .bold()
                                    .padding(.leading, 50.0)
                            } //closing of NavigationLink
                        } //closing of HStack
                    } //closing of ForEach
                    .onDelete(perform: removeHabit)
                } //closing of Section
            } //closing of List
            .navigationTitle("Habits")
            .toolbar {
                Button("Add Activity", systemImage: "plus") {
                    showingAddActivityView = true
                } //closing of Button
                .sheet(isPresented: $showingAddActivityView) {
                    Text("show add activity view")
                    //AddActivityView(habits: habits)
                } //closing of Alert
            } //closing of .toolbar
        } //closing of NavStack

        .alert("Habit Complete?", isPresented: $showingTrackHabitView, presenting: selectedActivity) { activity in
            Button("High Five") {
                print("high five")
                selectedActivity = nil //reset after use
            }
            Button("Reset") {
                print("reset total")
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

    func resetTotal(activity: Activity) {
        print("reset total")
    } //closing of resetTotal

} //closing of ContentView

#Preview {
    ContentView()
}
