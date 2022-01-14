//
//  AddQuotationViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/14/21.
//

import UIKit

class AddQuotationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var quoteField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var quoteCountLabel: UILabel!
    
    var quoteCount: Int = 0
    var newQuotation: Quotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteField.delegate = self
        authorField.delegate = self
        
        quoteCountLabel.text = "Quotation #\(quoteCount)"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SavedTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if let quote = quoteField.text, !quote.isEmpty {
            if let author = authorField.text, !author.isEmpty {
                newQuotation = Quotation(quote: quote, author: author)
            }
            else {
                newQuotation = Quotation(quote: quote)
            }
            quoteField.text = nil
            authorField.text = nil
        }
        performSegue(withIdentifier: "saveUnwind", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }


    /*
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
     */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
