//
//  ParentViewController.swift
//  RM53
//
//  Created by Ayu on 8/22/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: nil)
    }

}
