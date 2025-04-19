//
//  Book.swift
//  Bookworm
//
//  Created by Christopher Smith on 3/23/25.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var lastRead: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, lastRead: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.lastRead = lastRead
    }
}
