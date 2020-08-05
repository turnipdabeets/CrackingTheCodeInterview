//: [Previous](@previous)

import Foundation

//: ### Design the data structures for an online book reader system

class OnlineBookReader {
    let user: User
    let library: Library
    
    init(user: User, library: Library){
        self.user = user
        self.library = library
    }
}

class User {
    
}

class Library {
    let books: [Book]
    let store: Store
    var activeBook: Book?
    
    init(books: [Book], store: Store) {
        self.books = books
        self.store = store
    }
    
    func addBook(){}
    func removeBook(){}
    func findBook(){}
}

class Store {
    let books: [Book]
    
    init(books: [Book]) {
        self.books = books
    }
    
    func purchaseBook(){}
    func browseBooks(){}
}

struct Book {
    let title: String
    let author: String
    let pages : [Page]
}

struct Page {
    let content: Content
}

struct Content {
    // handle markup & highlighting
}

//: [Next](@next)
