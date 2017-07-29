//
//  ContactsViewController.swift
//  RM53
//
//  Created by Ayu on 7/28/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLbl.text = name
        print(name)
    }
}
