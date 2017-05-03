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
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
    }
    
    // Reference other classes
    var gameData : GameData = GameData()
    var games : [Game] = []
    var database : Database = Database()
    
    override func viewDidLoad() {
        
        database.printDB()
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Make a new reference to the games data
        games = gameData.games

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return number of rows in section
        return database.gameNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameTableViewCell
        
        // Update the cell content for each row that was returned
        cell.nameLabel.text = database.gameNames[indexPath.row]
        //cell.thumbnailImageView.image = UIImage(named: games[indexPath.row].image)
        //cell.playersLabel.text = games[indexPath.row].players
        //descriptionLabel.text = games[indexPath.row].description
        //instructionsLabel.text = games[indexPath.row].instructions
        //cell.materialsLabel.text = games[indexPath.row].materials
        
        return cell
        
    }
}

