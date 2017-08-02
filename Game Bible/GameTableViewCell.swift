//
//  GameTableViewCell.swift
//  PreGame
//
//  Created by Nicholas Jones on 2017-02-25.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var playersLabel: UILabel!
    
    //@IBOutlet weak var materialsLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var materialImage1: UIImageView!
    
    @IBOutlet weak var materialImage2: UIImageView!
    
    @IBOutlet weak var materialImage3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
