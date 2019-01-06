//
//  TableViewCell.swift
//  OnTheMap
//
//  Created by  AminSaleh on 11/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var urlText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
