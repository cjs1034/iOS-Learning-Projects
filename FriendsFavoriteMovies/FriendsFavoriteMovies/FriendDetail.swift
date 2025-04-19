//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Christopher Smith on 1/18/25.
//

import SwiftUI

struct FriendDetail: View {
    @Bindable var friend: Friend
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
        }
        .navigationTitle("Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Cancel") {
                    context.delete(friend)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend)
    }
}
