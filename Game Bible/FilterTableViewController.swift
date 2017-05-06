//
//  FilterTableViewTableViewController.swift
//  PreGame
//
//  Created by Nicholas Jones on 2017-02-24.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit

class FilterTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Reference other classes
    var gameData : GameData = GameData()
    
    var games : [Game] = []
    var filteredGames : [Game] = []
    
    var playersSelected : Int = 0
    var hasCards = false
    var hasDice = false
    var hasCup = false
    var difficultySelected : Int = 0
    var actionSelected : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Make a new reference to the games data
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
                destinationController.previousIndexPathRow = indexPath.row
                destinationController.filteredGames = self.filteredGames
                destinationController.previousViewController = "FilterTableViewController"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameTableViewCell
        
        // Update the cell content for each row that was returned from filter
        cell.nameLabel.text = filteredGames[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: filteredGames[indexPath.row].image)
        cell.playersLabel.text = filteredGames[indexPath.row].players
        cell.materialsLabel.text = filteredGames[indexPath.row].materials
        
        return cell
    }
    
}

