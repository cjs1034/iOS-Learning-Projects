//
//  ContentView.swift
//  HWSChallenge3
//
//  Created by Christopher Smith on 4/2/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
//    @State private var users = [User]()

    var body: some View {
        NavigationStack { // Good practice to embed List in NavigationView
            List(users) { user in // No need for explicit id: \.id when conforming to Identifiable
                NavigationLink(value: user) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text("Active? \(user.isActive ? "Yes" : "No")")
                        Text("Company: \(user.company)")
                        Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .shortened))")
                        Text("Friends: \(user.friends.count)")
                    }
                }
            }
            .navigationTitle("FriendFace Users")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
        }
            
            }
            .task {
                // Only load if users array is empty to avoid reloading on every view appearance
                if users.isEmpty {
                    await loadData()
                }
            }
        
    }

    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        // Create and configure the JSON Decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Use ISO8601 strategy for the date string

        do {
            // 1. Fetch Data
            let (data, _) = try await URLSession.shared.data(from: url)

            // 2. Decode Data using the configured decoder
            do {
                let decodedUsers = try decoder.decode([User].self, from: data) // Decode into [User]
                // Update state on the main thread
                await MainActor.run {
//                     self.users = decodedUsers
                    
                    for user in decodedUsers {
                        modelContext.insert(user)
                    }
                    try? modelContext.save()
                }
            } catch {
                // Print the specific decoding error
                print("Error decoding JSON: \(error)")
            }
            
            

        } catch {
            // Print network or other errors during fetch
            print("Error fetching data: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
