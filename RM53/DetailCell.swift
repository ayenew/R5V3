//
//  DetailCell.swift
//  RM53
//
//  Created by Ayu on 8/12/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet var label1: UILabel!
    @IBOutlet var value1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
