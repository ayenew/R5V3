//
//  OpportunityCell.swift
//  RM53
//
//  Created by Ayu on 6/28/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OpportunityCell: UITableViewCell {
    @IBOutlet weak var relationship: UILabel!
    @IBOutlet weak var salesStage: UILabel!
    @IBOutlet weak var targetDate: UILabel!
    @IBOutlet weak var balance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
