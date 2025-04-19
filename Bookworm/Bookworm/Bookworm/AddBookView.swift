//
//  AddBookView.swift
//  Bookworm
//
//  Created by Christopher Smith on 3/23/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "General"
    @State private var review = ""
    @State private var lastRead = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "General"]
    
    var hasValidTitle: Bool {
        if title.isEmpty || title.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book*", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                
                DatePicker("Date Last Read?", selection: $lastRead, displayedComponents: .date)

                Section {
                    Button("Save") {
                        let newBook: Book
                        if author == "" || author.trimmingCharacters(in: .whitespaces).isEmpty {
                            newBook = Book(title: title, author: "Unknown", genre: genre, review: review, rating: rating, lastRead: lastRead)
                            //modelContext.insert(newBook)
                        } else {
                            newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, lastRead: lastRead)
                            //modelContext.insert(newBook)
                        }
                        
                        print("Book to save: \(newBook)") // Debug: Print the book
                                                
                        do {
                            modelContext.insert(newBook)
                            try modelContext.save()
                            print("Book saved successfully")
                        } catch {
                            print("Error saving book: \(error)")
                        }
                        
                        dismiss()
                    }
                    .disabled(hasValidTitle == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
