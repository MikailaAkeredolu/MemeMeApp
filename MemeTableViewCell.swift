//
//  MemeTableViewCell.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/1/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Top: UILabel!
    
    
    @IBOutlet weak var Bottom: UILabel!
    
    
    @IBOutlet weak var imageForTable: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
