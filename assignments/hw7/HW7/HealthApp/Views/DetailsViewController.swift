//
//  DetailsViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/20/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var displayQuote: Quotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let quote = displayQuote{
            quoteLabel.text = "\"\(quote.quote)\""
            authorLabel.text = "- \(quote.author)"
        } else {
            quoteLabel.text = "Quote: nil"
            authorLabel.text = "Author: nil"
        }

    }
    
    @IBAction func scheduleNotifPressed(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { (settings) in
            if settings.alertSetting == .enabled {
                self.scheduleNotification()
            } else {
                print("Notifications disabeled")
            }
        })
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Quote of the Day"
        content.body = displayQuote!.quote
        content.userInfo["id"] = displayQuote!.id
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: "QuoteOfTheDay", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
        })
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
