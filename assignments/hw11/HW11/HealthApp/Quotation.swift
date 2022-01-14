//
//  Quotation.swift
//  HealthApp
//
//  Created by Connor Easton on 1/28/21.
//

import Foundation

class Quote {
    var quote: String
    var author: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
    init(quote: String) {
        self.quote = quote
        self.author = "Anonymous"
    }
    
}
