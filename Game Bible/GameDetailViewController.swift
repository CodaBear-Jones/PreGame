//
//  GameDetailViewController.swift
//  Game Bible
//
//  Created by Nicholas Jones on 2017-02-23.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var game:Game!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Update the game details
        //gameNameLabel.text = game.name
        title = game.name
        gameImageView.image = UIImage(named: game.image)
        
        // Change the colours of the view
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameDetailTableViewCell
    
     // Configure the cell...
    switch indexPath.row {
        
    case 0:
        cell.fieldLabel.text = "Name"
        cell.valueLabel.text = game.name
        
    case 1:
        cell.fieldLabel.text = "Players"
        cell.valueLabel.text = game.players
        
    case 2:
        cell.fieldLabel.text = "Description"
        cell.valueLabel.text = game.description
        
    case 3:
        cell.fieldLabel.text = "Instructions"
        cell.valueLabel.text = game.instructions
        
    default:
        cell.fieldLabel.text = "Default Field"
        cell.valueLabel.text = "Default Value"
        
    }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
}
