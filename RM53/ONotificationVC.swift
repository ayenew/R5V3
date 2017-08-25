//
//  ONotificationVC.swift
//  RM53
//
//  Created by Ayu on 8/24/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ONotificationVC: OParentVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Notification"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

}
