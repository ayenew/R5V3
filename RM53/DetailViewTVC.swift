//
//  DetailViewTVC.swift
//  RM53
//
//  Created by Ayu on 8/12/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class DetailViewTVC: UITableViewController {
    
    var value1 = String()
    var value2 = String()
    var value3 = String()
    var value4 = String()
    
    var label1 = String()
    var label2 = String()
    var label3 = String()
    var label4 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        switch indexPath.row {
        case 0:
            cell.label1.text = label1
            cell.value1.text = value1
        case 1:
            cell.label1.text = label2
            cell.value1.text = value2
        case 2:
            cell.label1.text = label3
            cell.value1.text = value3
        case 3:
            cell.label1.text = label4
            cell.value1.text = value4
        default: break
        }
        return cell
    }

}
