//
//  OverViewCell.swift
//  RM53
//
//  Created by Ayu on 7/30/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverViewCell: UITableViewCell {

    @IBOutlet weak var workPhone: UILabel!
    @IBOutlet weak var cellPhone: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
