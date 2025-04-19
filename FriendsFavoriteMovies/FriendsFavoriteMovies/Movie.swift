//
//  Movie.swift
//  FriendsFavoriteMovies
//
//  Created by Christopher Smith on 1/17/25.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    static let sampleData = [
        Movie(title: "Interstellar", releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "La La Land", releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),
        Movie(title: "Saving Private Ryan", releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),
        Movie(title: "Crazy Stupid Love", releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),
        Movie(title: "John Wick", releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),
        Movie(title: "Mission Impossible", releaseDate: Date(timeIntervalSinceReferenceDate: -1_700_000_000)),
    ]
}
