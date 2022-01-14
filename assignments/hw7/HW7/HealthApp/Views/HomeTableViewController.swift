//
//  HomeTableViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/20/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var quoteList: [Quotation] = []
    var displayedQuotes: [Quotation] = []
    var quoteCount = 0
    var index = 0
    var QOTDid:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadQuotes()
        self.tableView.reloadData()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func LoadQuotes() {
        quoteList.append(Quotation(quote: "Hello World", author: "Connor Easton - 2016"))
        quoteList.append(Quotation(quote: "Mysterious Man"))
        quoteList.append(Quotation(quote: "This is a super long quote to show how the text will wrap when the text is too long to fit horozontally"))

        quoteList.append(Quotation(quote: "Meow", author: "My Cat"))
        quoteCount = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("")
        processQuotes()
    }
    
    func processQuotes(){
        var filteredQuotes = quoteList
        if (UserDefaults.standard.bool(forKey: Constants.main.filterAnonKey)){
            filteredQuotes = quoteList.filter({ (quote) -> Bool in quote.author != "Anonymous"})
        }
        if (UserDefaults.standard.bool(forKey: Constants.main.sortQuotesKey)){
            displayedQuotes = filteredQuotes.sorted(by: {(q1, q2) -> Bool in q1.quote < q2.quote})
        } else {
            displayedQuotes = filteredQuotes
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuoteSegue"{
            let quoteVC = segue.destination as! AddQuotationViewController
            quoteVC.quoteCount = self.quoteCount
        }
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.displayQuote = displayedQuotes[tableView.indexPathForSelectedRow!.row]
        }
        
       
    }
    
    @IBAction func unwindFromSecondView (sender: UIStoryboardSegue) {
        if sender.identifier == "saveUnwind" {
            let quoteVC = sender.source as! AddQuotationViewController
            if let newQuote = quoteVC.newQuotation {
                quoteList.append(newQuote)
                quoteCount += 1
            }
        }
        processQuotes()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displayedQuotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        // Configure the cell...
        let quote = displayedQuotes[indexPath.row]
        cell.textLabel?.text = quote.quote
        if(UserDefaults.standard.bool(forKey: Constants.main.showAuthorsKey)){
            cell.detailTextLabel?.text = quote.author
        } else {
            cell.detailTextLabel?.text = nil
        }
        if(quote.id == QOTDid){
            cell.textLabel?.textColor = UIColor.red
        } else {
            cell.textLabel?.textColor = UIColor.black
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let delQuote = displayedQuotes[indexPath.row]
            let index = quoteList.firstIndex { (fi) -> Bool in fi === delQuote}

            let alert = UIAlertController(title: "Delete Quote?", message: delQuote.quote, preferredStyle: .alert)
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                
                // Delete the row from the data source
                self.displayedQuotes.remove(at: index!)
                self.quoteList.remove(at: index!)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Notifications
    
    
    func handleNotification(_ response: UNNotificationResponse) {
        let message = response.notification.request.content.userInfo["id"] as! String
        self.QOTDid = message
        processQuotes()
        print("received notification meagge: \(message)")
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
