//
//  ViewController.swift
//  Game Bible
//
//  Created by Nicholas Jones on 2017-02-13.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit

class GameTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Reference other classes
    var gameData : GameData = GameData()
    var games : [Game] = []
    var database : Database = Database()
    
    // Declare the search variables
    var searchController : UISearchController!
    var searchResults : [Game] = []
    
    override func viewDidLoad() {
        
        database.printDB()
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Make a new reference to the games data
        games = gameData.games
        
        // Update the search bar
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Games"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        
        // Creat a point to off set the table view, hiding the search bar under the navigation controller
        let point = CGPoint(x: 0, y:(self.navigationController?.navigationBar.frame.size.height)!)
        self.tableView.setContentOffset(point, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Unselect the previously selected row
        if tableView.indexPathForSelectedRow != nil {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Set a destination
        if segue.identifier == "showGameDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! GameDetailViewController
                destinationController.game = games[indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            self.games[indexPath.row].favorite = true
        }
        favorite.backgroundColor = UIColor.lightGray
        return [favorite]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    func filterContent(for searchText: String) {
    //        searchResults = games.filter({(Game) -> Bool in if let name = games.name {
    //            let isMatch = name.localizedCaseInsensitiveContains(searchText)
    //            return isMatch
    //            }
    //            return false
    //        })
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return number of rows in section
        return games.count
        
        // Enter the search screen
        if searchController.isActive {
            return searchResults.count
        } else {
            return games.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameTableViewCell
        
        // Update the cell content for each row that was returned
        cell.nameLabel.text = games[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: games[indexPath.row].image)
        cell.playersLabel.text = games[indexPath.row].players
        //descriptionLabel.text = games[indexPath.row].description
        //instructionsLabel.text = games[indexPath.row].instructions
        cell.materialsLabel.text = games[indexPath.row].materials
        
        return cell
        
    }
}

