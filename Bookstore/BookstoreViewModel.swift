//
//  BookstoreViewModel.swift
//  Bookstore
//
//  Created by Paweł Dziennik on 19/07/2019.
//

import Foundation

struct BookstoreViewModel {
    let books: [BookViewModel]
}

struct BookViewModel {
    let author: String
    let pages: Int
    let type: BookType
    let identifier: String
    
    init(book: Book) {
        author = book.author
        pages = book.pages
        identifier = book.identifier
        type = BookType(rawValue: book.type) ?? .criminal
        
    }
}

enum BookType: String {
    case criminal
}
