//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Christopher Smith on 1/17/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static let sampleData = [
        Friend(name: "Archie"),
        Friend(name: "Alyssa"),
        Friend(name: "Chris"),
        Friend(name: "Matt"),
        Friend(name: "Cole"),
    ]
}
