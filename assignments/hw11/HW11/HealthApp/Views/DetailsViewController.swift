//
//  DetailsViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/20/21.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var displayQuote: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let quote = displayQuote{
            quoteLabel.text = "\"\(quote.value(forKey: "quote") as! String)\""
            authorLabel.text = "- \(quote.value(forKey: "author") as! String)"
        } else {
            quoteLabel.text = "Quote: nil"
            authorLabel.text = "Author: nil"
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
