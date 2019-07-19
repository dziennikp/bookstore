//
//  BookstoreStore.swift
//  Bookstore
//
//  Created by Paweł Dziennik on 19/07/2019.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import ObjectMapper

public class BookstoreStore {
    let viewModelRelay = BehaviorRelay<BookstoreViewModel?>(value: nil)
    
    public required init() {
        try? realm()?.write {
            realm()?.deleteAll()
        }
        fetchData()
    }
    
    func realm() -> Realm? {
        return try? Realm(configuration: Realm.Configuration(objectTypes: [Book.self] ))
    }
    
    private func fetchData() {
        guard let file = Bundle.main.url(forResource: "Books", withExtension: "json"),
        let contents = try? Data(contentsOf: file),
        let json = try? JSONSerialization.jsonObject(with: contents, options: .allowFragments),
        let jsonResult = json as? [String: Any],
        let books = jsonResult["books"] as? [[String: Any]]
            else { return }
        
        books
            .compactMap { Mapper<Book>().map(JSON: $0) }
            .forEach { book in
                try? realm()?.write {
                    realm()?.add(book)
                }
            }
    }
    
    func createViewModel() {
        guard let realm = realm() else { return }
        let bookViewModels: [BookViewModel] =  realm.objects(Book.self).map { BookViewModel(book: $0) }
        viewModelRelay.accept(BookstoreViewModel(books: bookViewModels))
    }
}



