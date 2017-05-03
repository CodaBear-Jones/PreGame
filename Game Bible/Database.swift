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
    
    var gameNames : [String] = []
    
    
    func printDB() {
        
        do {
            let db = try Connection((Bundle.main.path(forResource: "DrinkingGameDatabase", ofType: "sqlite3"))!)
            
            let games = Table("Games")
            
            let id = Expression<Int>("ID")
            let name = Expression<String?>("name")
            
            for game in try db.prepare(games) {
                //print("id: \(game[id]), name: \(game[name])")
                
                let optionalGameNames : [String?] = [game[name]]
                
                for gameNames in optionalGameNames {
                    
                    guard let gameNames = gameNames else {
                        print("Was not able to unwrap game names")
                        continue
                    }
                    
                    self.gameNames += [gameNames]
            
                }
    
            }
            
             print(gameNames, "\n")
            
        } catch {
            print("DB Error")
        }
        
    }
}
