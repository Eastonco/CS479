//
//  ViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 1/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    var images = ["child.jpg", "stepbrothers.JPG", "cow.jpg"]
    var index = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func NextTapped(_ sender: Any) {
        if index == 2 {
            index = 0
        } else {
            index += 1
        }
        imageView.image = UIImage(named: images[index])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        index = 0
        imageView.image = UIImage(named: images[index])
    }


}

