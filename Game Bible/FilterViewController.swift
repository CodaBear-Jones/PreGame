//
//  FilterViewController.swift
//  PreGame
//
//  Created by Nicholas Jones on 2017-03-02.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

// Materials include... Card Deck, Shot Glasses, Solo Cups, TV, Coins, Quarters, Dice, Poker Chips, Pen, Beer Cans, Beer Bottels, Hard Alcohol, Beer Bong, Ping Pong Balls,


import UIKit
import SQLite

class FilterViewController: UIViewController, BEMCheckBoxDelegate {
    
    @IBOutlet weak var playersSegment: UISegmentedControl!
    @IBOutlet weak var deckOfCardsCheckbox: BEMCheckBox!
    @IBOutlet weak var pairOfDiceCheckbox: BEMCheckBox!
    @IBOutlet weak var dominosCheckbox: BEMCheckBox!
    @IBOutlet weak var difficultySegment: UISegmentedControl!
    @IBOutlet weak var actionSegment: UISegmentedControl!
    
    // Reference other classes
    var gameData : GameData = GameData()
    var games : [Game] = []
    var database : Database = Database()
    
    // Set the selected variables to their default
    var playersSelected = 1
    var hasDeckOfCards = false
    var hasPairOfDice = false
    var hasDominos = false
    var difficultySelected = 1
    var actionSelected = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Make a new reference to the games data
        games = gameData.games
    }
    
    override func viewDidAppear(_ animated: Bool) {
        deckOfCardsCheckbox.delegate = self
        pairOfDiceCheckbox.delegate = self
        dominosCheckbox.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        // Update the variables when a box is tapped
        hasDeckOfCards = deckOfCardsCheckbox.on
        hasPairOfDice = pairOfDiceCheckbox.on
        hasDominos = dominosCheckbox.on
    }
    
    // Update the variables when a segement is updated
    @IBAction func playersChanged(_ sender: Any) {
        switch playersSegment.selectedSegmentIndex {
        case 0:
            playersSelected = 1
        case 1:
            playersSelected = 2
        case 2:
            playersSelected = 3
        case 3:
            playersSelected = 4
        case 4:
            playersSelected = 5
        case 5:
            playersSelected = 6
        default:
            playersSelected = 1
        }
    }
    @IBAction func difficultyChanged(_ sender: Any) {
        switch difficultySegment.selectedSegmentIndex {
        case 0:
            difficultySelected = 1
        case 1:
            difficultySelected = 2
        case 2:
            difficultySelected = 3
        case 3:
            difficultySelected = 4
        default:
            difficultySelected = 1
        }
    }
    @IBAction func actionChanged(_ sender: Any) {
        switch actionSegment.selectedSegmentIndex {
        case 0:
            actionSelected = 1
        case 1:
            actionSelected = 2
        case 2:
            actionSelected = 3
        case 3:
            actionSelected = 4
        default:
            actionSelected = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Set a destination
        if segue.identifier == "showAvailableGames" {
            let destinationController = segue.destination as! FilterTableViewController
            
            // Send the data
            destinationController.playersSelected = self.playersSelected
            destinationController.difficultySelected = self.difficultySelected
            destinationController.actionSelected = self.actionSelected
            destinationController.hasDominos = self.hasDominos
            destinationController.hasPairOfDice = self.hasPairOfDice
            destinationController.hasDeckOfCards = self.hasDeckOfCards
            
            // Create an empty array
            var filteredGames = [Game]()
            
            // Categorize by materials
            var cardGames = games.filter({$0.deckOfCards == true})
            var diceGames = games.filter({$0.pairOfDice == true})
            var dominoGames = games.filter({$0.dominos == true})
            
            // Different selection scenario, four for each maerial
            if hasDeckOfCards == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasDeckOfCards == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasDeckOfCards == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasDeckOfCards == true && difficultySelected == 4 && actionSelected != 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action == actionSelected) && ($0.difficulty <= 3)})
            }
            
            if hasPairOfDice == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasPairOfDice == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasPairOfDice == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasPairOfDice == true && difficultySelected == 4 && actionSelected != 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action == actionSelected) && ($0.difficulty <= 3)})
            }
            
            if hasDominos == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasDominos == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasDominos == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasDominos == true && difficultySelected == 4 && actionSelected != 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.action == actionSelected) && ($0.difficulty <= 3)})
            }
            
            destinationController.filteredGames = filteredGames
            
            if filteredGames.count == 0 {
                
                let alert = UIAlertController(title: "No Results", message: "There are no games that match your filter", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                alert.view.tintColor = UIColor(red: 210.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                
            }
        }
    }
}
