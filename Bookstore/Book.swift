//
//  Book.swift
//  Bookstore
//
//  Created by Paweł Dziennik on 19/07/2019.
//

import Foundation
import ObjectMapper
import RealmSwift

class Book: Object, Mappable {
    
    @objc dynamic let identifier = UUID().uuidString
    @objc dynamic var author = ""
    @objc dynamic var pages = 0
    @objc dynamic var type = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        pages <- map["pages"]
        type <- map["type"]
    }
}
