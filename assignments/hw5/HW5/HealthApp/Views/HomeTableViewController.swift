//
//  HomeTableViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/20/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var quoteList: [Quotation] = []
    var quoteCount = 0
    var index = 0

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
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuoteSegue"{
            let quoteVC = segue.destination as! AddQuotationViewController
            quoteVC.quoteCount = self.quoteCount
        }
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.displayQuote = quoteList[tableView.indexPathForSelectedRow!.row]
            // TODO: finish me
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
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quoteList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        // Configure the cell...
        let quote = quoteList[indexPath.row]
        cell.textLabel?.text = quote.quote
        cell.detailTextLabel?.text = quote.author

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
            // Delete the row from the data source
            quoteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
