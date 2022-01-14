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
    @IBOutlet weak var timerSelect: UISlider!
    @IBOutlet weak var delayLabel: UILabel!
    
    var quoteList = [Quotation]()
    var index = 0
    var timer: Timer?
    var timerLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteField.delegate = self
        authorField.delegate = self
        quoteList.append(Quotation(quote: "Hello World", author: "Connor Easton - 2016"))
        quoteList.append(Quotation(quote: "Mysterious Man"))
        quoteList.append(Quotation(quote: "Meow", author: "My Cat"))
        
        if let author = quoteList[index].author {
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + author
        }else{
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + "Anonymous"
        }
        index += 1
        
        timerSelect.value = Float(timerLength)
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timerLength), repeats: false, block: handleTick)
        
        TimeChanged(timerSelect)

        

    }
    
    func handleTick (timer: Timer) {
        DisplayNextQuote()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timerLength), repeats: false, block: handleTick)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func AddTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if let quote = quoteField.text, !quote.isEmpty {
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
    
    
    @IBAction func TimeChanged(_ sender: UISlider) {
        timerLength = Int(timerSelect.value)
        delayLabel.text = "Delay \(timerLength)s"
    }
    
    
    func DisplayNextQuote(){
        if let author = quoteList[index].author {
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + author
        }
        else {
            quoteDisplay.text = "\"" + quoteList[index].quote + "\"\n" + "Anonymous"
        }
        if(index < quoteList.count - 1){
            index += 1
        }
        else {
            index = 0
        }
    }
    
    
}

