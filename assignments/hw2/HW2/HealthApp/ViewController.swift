//
//  ViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 1/21/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quoteField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var quoteDisplay: UILabel!
    
    var quoteList = [Quotation]()
    var quoteCount = 0
    var index = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteField.delegate = self
        authorField.delegate = self
        quoteList.append(Quotation(quote: "Hello World", author: "Connor Easton - 2016"))
        quoteList.append(Quotation(quote: "Mysterious Man"))
        quoteList.append(Quotation(quote: "Meow", author: "My Cat"))
        quoteCount = 3
        
        if let author = quoteList[index].author {
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + author
        }else{
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + "Anonymous"
        }
        index += 1

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func AddTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if let quote = quoteField.text, !quote.isEmpty {
            quoteCount += 1
            if let author = authorField.text, !author.isEmpty {
                quoteList.append(Quotation(quote: quote, author: author))
            }
            else {
                quoteList.append(Quotation(quote: quote))
            }
            quoteField.text = nil
            authorField.text = nil
        }
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        if let author = quoteList[index].author {
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + author
        }else{
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + "Anonymous"
        }
        
        if(index < quoteCount - 1){
            index += 1
        }
        else{
            index = 0
        }
    }
}

