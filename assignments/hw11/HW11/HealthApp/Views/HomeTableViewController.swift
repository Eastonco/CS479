//
//  HomeTableViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 2/20/21.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
    
    var quoteList: [NSManagedObject] = []
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        quoteList = fetchQuotes()
        self.tableView.reloadData()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func insertQuote(quote: String, author: String?){
        let newQuote = NSEntityDescription.insertNewObject(forEntityName: "Quotation", into: self.managedObjectContext)
        newQuote.setValue(quote, forKey: "quote")
        if let auth = author {
            newQuote.setValue(auth, forKey: "author")
        }
        appDelegate.saveContext()
        quoteList.append(newQuote)
    }
    
    func fetchQuotes() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Quotation")
        var quotes: [NSManagedObject] = []
        do {
            quotes = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("getQuotes error: \(error)")
        }
        return quotes
    }
    
    func deleteQuote(_ quote: NSManagedObject){
        managedObjectContext.delete(quote)
        appDelegate.saveContext()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuoteSegue"{
            let quoteVC = segue.destination as! AddQuotationViewController
            quoteVC.quoteCount = self.quoteList.count
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
            if let newQuote = quoteVC.quoteReturn {
                if let author = quoteVC.authorReturn{
                    insertQuote(quote: newQuote, author: author)
                }
                else{
                    insertQuote(quote: newQuote, author: nil)
                }
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
        cell.textLabel?.text = quote.value(forKey: "quote") as? String
        cell.detailTextLabel?.text = quote.value(forKey: "author") as? String

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
            let quote = quoteList[indexPath.row]
            quoteList.remove(at: indexPath.row)
            deleteQuote(quote)
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

