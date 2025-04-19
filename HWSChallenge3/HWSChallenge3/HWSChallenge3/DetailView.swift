//
//  DetailView.swift
//  HWSChallenge3
//
//  Created by Christopher Smith on 4/3/25.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("User Data")
                        .font(.title2)
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    
                    Divider()
                    
                    Text("About")
                        .font(.title2)
                    Text(user.about)
                    
                    Divider()
                    
                    Text("Friends:")
                        .font(.title2)
                    ForEach(user.friends, id: \.self) { friend in
                        Text(friend.name)
                    }
                    
                    Divider()
                    
                    Text("Tags")
                       .font(.title2)
                       .padding(.top)
                     Text(user.tags.joined(separator: ", ")) // Will align left
                        .padding(.bottom)

                    
                }
                .padding(.horizontal)
            }
            .navigationTitle(user.name)
        }
    }
}

#Preview {
//    // Create sample friends first
//        let sampleFriend1 = Friend(id: "friend-1", name: "Alice")
//        let sampleFriend2 = Friend(id: "friend-2", name: "Bob")
//
//        // Create a sample User instance
//        let sampleUser = User(
//            id: "user-1",
//            isActive: true,
//            name: "Sample User",
//            age: 30,
//            company: "Sample Inc.",
//            email: "sample.user@example.com",
//            address: "123 Sample St, Sampleville",
//            about: "This is a sample user bio for the SwiftUI preview. It describes the user's interests and background.",
//            registered: Date(), // Use current date for simplicity
//            tags: ["sample", "preview", "swiftui"],
//            friends: [sampleFriend1, sampleFriend2]
//        )
//    
//    DetailView(user: sampleUser)
}
