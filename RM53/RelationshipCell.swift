//
//  RelationshipCell.swift
//  RM53
//
//  Created by Ayu on 8/10/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class RelationshipCell: UITableViewCell {

    @IBOutlet weak var meetingImg: UIImageView!
    @IBOutlet weak var notifImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: [String:Any]){
        titleLbl.text = item["name"] as! String?
        if item["meeting"] as! Int > 0 && item["notification"] as! Int > 0 {
            meetingImg.tintColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
            meetingImg.isHidden = false
            notifImg.tintColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
            notifImg.isHidden = false
        } else if item["meeting"] as! Int > 0 && item["notification"] as! Int == 0 {
            meetingImg.tintColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
            meetingImg.isHidden = false
            notifImg.isHidden = true
        } else if item["meeting"] as! Int == 0 && item["notification"] as! Int > 0 {
            meetingImg.image = UIImage(named: "smallbell")
            meetingImg.tintColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
            meetingImg.isHidden = false
            notifImg.isHidden = true
        } else {
            meetingImg.isHidden = true
            notifImg.isHidden = true
        }
        
    }

}
