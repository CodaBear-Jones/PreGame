//
//  FilterTableViewCell.swift
//  Game Bible
//
//  Created by Nicholas Jones on 2017-03-02.
//  Copyright © 2017 Nicholas Jones. All rights reserved.
//

import UIKit



class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var materialsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
