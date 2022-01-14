//
//  TableViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 3/30/21.
//



import UIKit
import SafariServices

class TableViewController: UITableViewController {
    
    let APIKey = "e0a1b2d0f2074f01aac1fb1d270ec8fd"
    
    var newsArticles: [NewsItem] = []
    var totalResults: Int = 0

    @IBAction func updatedBtnTapped(_ sender: Any) {
        newsArticles = []
        totalResults = 0
        getNews()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
        
        print("did it work?")


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getNews() {
        let newsURL = "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=\(APIKey)"
        if let urlStr = newsURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string: urlStr){
                let dataTask = URLSession.shared.dataTask(with: url, completionHandler: handleNewsResponse)
                dataTask.resume()
            }
        }
    }
    
    func handleNewsResponse (data: Data?, response: URLResponse?, error: Error?){
        
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            return
        }
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        
        guard let somedata = data else {
            print("error: no data")
            return
        }
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
              let jsonResponse = jsonObj as? [String: Any],
              let resultCount = jsonResponse["totalResults"] as? Int,
              let articleArray = jsonResponse["articles"] as? [Any],
              articleArray.count > 0,
              let jsonDict2 = articleArray[0] as? [String: Any],
              let _ = jsonDict2["title"] as? String,
              let _ = jsonDict2["urlToImage"] as? String else {
            print("error: invalidJSON data")
            return
        }
        
        print(jsonResponse)
        
        totalResults = resultCount
        
        populateArticleArray(articles: articleArray)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        loadNewsImage()
    }
    
    func populateArticleArray(articles:[Any]){
        for article in articles {
            let article = article as! [String: Any]
            let event = NewsItem()
            if let sourceData = article["source"] as? [String: Any] {
                if let source = sourceData["name"] as? String {
                    event.source = source
                }
            }
            if let imageUrl = article["urlToImage"] as? String {
                event.imageUrl = imageUrl
            }
            if let url = article["url"] as? String {
                event.URL = url
            }
            if let title = article["title"] as? String {
                event.title = title
            }
            
            newsArticles.append(event)
        }
    }
    
    func loadNewsImage()  {
        for item in newsArticles {
            if let urlStr = item.imageUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: urlStr) {
                    let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            item.image = image
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    })
                    dataTask.resume()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalResults
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        cell.textLabel?.text = newsArticles[indexPath.row].title
        cell.detailTextLabel?.text = newsArticles[indexPath.row].source
        if let image = newsArticles[indexPath.row].image{
            cell.imageView?.image = image
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let website = newsArticles[indexPath.row].URL {
            let url = URL(string: website)!
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
