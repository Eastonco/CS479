//
//  Quotation.swift
//  HealthApp
//
//  Created by Connor Easton on 1/28/21.
//

import Foundation

class Quotation {
    var quote: String
    var author: String
    var id: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
        self.id = UUID().uuidString
    }
    
    init(quote: String) {
        self.quote = quote
        self.author = "Anonymous"
        self.id = UUID().uuidString
    }
    
}
