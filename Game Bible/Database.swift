//
//  Database.swift
//  PreGame
//
//  Created by Nicholas Jones on 2017-04-30.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import Foundation
import SQLite

class Database {
    
    var db : Connection!
    
    var gameNames : [String] = []
    var gameDescriptions : [String] = []
    var gamePlayers : [String] = []
    var gameMaterials : [String] = []
    
    let games = Table("Games")
    let id = Expression<Int>("ID")
    let name = Expression<String?>("name")
    let players = Expression<String?>("players")
    let materials = Expression<String?>("materials")
    let description = Expression<String>("description")
    let difficulty = Expression<Int>("difficulty")
    let action = Expression<Int>("action")
    
    var playersSelected = 0
    var complexitySelected = 0
    var drunknessSelected = 0
    
    var hasCards = false
    var hasDice = false
    var hasCup = false
    var hasBall = false
    var hasCoins = false
    var hasShotGlass = false
    var hasPokerChips = false
    
    func printDB() {
        
        do {
            
            db = try Connection((Bundle.main.path(forResource: "DrinkingGameDatabase", ofType: "sqlite3"))!)
            
            for game in try db.prepare(games) {
                let optionalGameNames : [String?] = [game[name]]
                for gameNames in optionalGameNames {
                    guard let gameNames = gameNames else {
                        print("Was not able to unwrap game names")
                        continue
                    }
                    self.gameNames += [gameNames]
                    
                }
                
            }
        
            for game in try db.prepare(games) {
                let optionalGameDescriptions : [String?] = [game[description]]
                for gameDescriptions in optionalGameDescriptions {
                    guard let gameDescriptions = gameDescriptions else {
                        print("Was not able to unwrap game descriptions")
                        continue
                    }
                    self.gameDescriptions += [gameDescriptions]
                    
                }
                
            }
            
            for game in try db.prepare(games) {
                let optionalGamePlayers : [String?] = [game[players]]
                for gamePlayers in optionalGamePlayers {
                    guard let gamePlayers = gamePlayers else {
                        print("Was not able to unwrap game players")
                        continue
                    }
                    self.gamePlayers += [gamePlayers]
                    
                }
                
            }
            
            for game in try db.prepare(games) {
                let optionalGameMaterials : [String?] = [game[materials]]
                for gameMaterials in optionalGameMaterials {
                    guard let gameMaterials = gameMaterials else {
                        print("Was not able to unwrap game materials")
                        continue
                    }
                    self.gameMaterials += [gameMaterials]
                    
                }
                
            }
            
        } catch {
            print("Database Error")
        }
        
        var stringPlayersRequired = [Character]()
        
        for i in gamePlayers {
            stringPlayersRequired.append(i.characters.first!)
        }
    }
    
    func filterGames() {
        
        do {
        let query = games.filter(difficulty == complexitySelected && action == drunknessSelected)
        for game in try db.prepare(query) {
            print("Filtered Games: ", game[name])
        }
        
        } catch {
            print("Cannot filter games")
        }
    }
}
