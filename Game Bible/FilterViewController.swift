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
    @IBOutlet weak var difficultySegment: UISegmentedControl!
    @IBOutlet weak var actionSegment: UISegmentedControl!
    
    @IBAction func SoloCupButton(_ sender: UIButton) {
    
        if hasCup {
            sender.setImage(UIImage(named:"CupMaterial.png"), for: .normal)
            hasCup = false
        } else {
            sender.setImage(UIImage(named:"CupMaterialFilled.png"), for: .normal)
            hasCup = true
        }
        
    }
    @IBAction func BallButton(_ sender: UIButton) {
        
        if hasBall {
            sender.setImage(UIImage(named:"BallMaterial.png"), for: .normal)
            hasBall = false
        } else {
            sender.setImage(UIImage(named:"BallMaterialFilled.png"), for: .normal)
            hasBall = true
        }
        
    }
    @IBAction func CardsButton(_ sender: UIButton) {
        
        if hasCards {
            sender.setImage(UIImage(named:"CardsMaterial.png"), for: .normal)
            hasCards = false
        } else {
            sender.setImage(UIImage(named:"CardsMaterialFilled.png"), for: .normal)
            hasCards = true
        }

        
    }
    @IBAction func DiceButton(_ sender: UIButton) {
        
        if hasDice {
            sender.setImage(UIImage(named:"DiceMaterial.png"), for: .normal)
            hasDice = false
        } else {
            sender.setImage(UIImage(named:"DiceMaterialFilled.png"), for: .normal)
            hasDice = true
        }

        
    }
    @IBAction func CoinsButton(_ sender: UIButton) {
        
        if hasCoins {
            sender.setImage(UIImage(named:"CoinsMaterial.png"), for: .normal)
            hasCoins = false
        } else {
            sender.setImage(UIImage(named:"CoinsMaterialFilled.png"), for: .normal)
            hasCoins = true
        }

        
    }
    @IBAction func ShotGlassButton(_ sender: UIButton) {
        
        if hasShotGlass {
            sender.setImage(UIImage(named:"ShotGlassMaterial.png"), for: .normal)
            hasShotGlass = false
        } else {
            sender.setImage(UIImage(named:"ShotGlassMaterialFilled.png"), for: .normal)
            hasShotGlass = true
        }

        
    }
    @IBAction func PokerChipsButton(_ sender: UIButton) {
        
        if hasPokerChips {
            sender.setImage(UIImage(named:"PokerChipsMaterial.png"), for: .normal)
            hasPokerChips = false
        } else {
            sender.setImage(UIImage(named:"PokerChipsMaterialFilled.png"), for: .normal)
            hasPokerChips = true
        }

        
    }
    
    // Reference other classes
    var gameData : GameData = GameData()
    var games : [Game] = []
    var database : Database = Database()
    
    // Set the selected variables to their default
    var playersSelected = 1
    
    var difficultySelected = 1
    var actionSelected = 1
    
    var hasCards = false
    var hasDice = false
    var hasCup = false
    var hasBall = false
    var hasCoins = false
    var hasShotGlass = false
    var hasPokerChips = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Make a new reference to the games data
        games = gameData.games
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // FIX - CHECK BOXES HISTORY
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
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
            destinationController.hasCup = self.hasCup
            destinationController.hasDice = self.hasDice
            destinationController.hasCards = self.hasCards
            
            // Create an empty array
            var filteredGames = [Game]()
            
            // Categorize by materials
            var cardGames = games.filter({$0.deckOfCards == true})
            var diceGames = games.filter({$0.pairOfDice == true})
            var dominoGames = games.filter({$0.dominos == true})
            
            // Different selection scenario, four for each maerial
            if hasCards == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasCards == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasCards == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasCards == true && difficultySelected == 4 && actionSelected != 4 {
                filteredGames += cardGames.filter({($0.playersRequired <= playersSelected) && ($0.action == actionSelected) && ($0.difficulty <= 3)})
            }
            
            if hasDice == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasDice == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasDice == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasDice == true && difficultySelected == 4 && actionSelected != 4 {
                filteredGames += diceGames.filter({($0.playersRequired <= playersSelected) && ($0.action == actionSelected) && ($0.difficulty <= 3)})
            }
            
            if hasCup == true && difficultySelected != 4 && actionSelected != 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.difficulty == difficultySelected) && ($0.action == actionSelected)})
            } else if hasCup == true && difficultySelected == 4 && actionSelected == 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty <= 3)})
            } else if hasCup == true && difficultySelected != 4 && actionSelected == 4 {
                filteredGames += dominoGames.filter({($0.playersRequired <= playersSelected) && ($0.action <= 3) && ($0.difficulty == difficultySelected)})
            } else if hasCup == true && difficultySelected == 4 && actionSelected != 4 {
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
