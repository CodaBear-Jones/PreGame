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
        
        
        
        
        let query = games.filter(id == 0)//difficulty == 1 && action == 1)
        
        do {
            
            for game in try db.prepare(query) {
                //print(game[name])
            }
            
        } catch {
            print("Database Error")
        }
        
        
        
        
        
        
        
        
    }
}
