//
//  CategoryTableViewController.swift
//  Game Bible
//
//  Created by Nicholas Jones on 2017-03-12.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit

class CategoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var categories = ["Card Games", "Dice Games", "Domino Games", "Casino Games"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of rows in section
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
}
