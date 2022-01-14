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
    
    
    // FIXME: this shit sucks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quoteVC = segue.destination as! AddQuotationViewController
        quoteVC.quoteCount = self.quoteCount
    }
    
    @IBAction func unwindFromSecondView (sender: UIStoryboardSegue) {
        if sender.identifier == "saveUnwind" {
            let quoteVC = sender.source as! AddQuotationViewController
            if let newQuote = quoteVC.newQuotation {
                quoteList.append(newQuote)
                quoteCount += 1
            }
        }

        
    }
}

