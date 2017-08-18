//
//  DetailViewTVC.swift
//  RM53
//
//  Created by Ayu on 8/12/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class DetailViewTVC: UITableViewController {
    
    var value1 = String(), value2 = String(), value3 = String(), value4 = String(),value5 = String(), value6 = String(), value7 = String(), value8 = String(),value9 = String(), value10 = String(), value11 = String(), value12 = String(), value13 = String(), value14 = String(), value15 = String()
    
    var label1 = String(), label2 = String(), label3 = String(), label4 = String(), label5 = String(), label6 = String(), label7 = String(), label8 = String(), label9 = String(), label10 = String(),label11 = String(), label12 = String(), label13 = String(), label14 = String(), label15 = String()
    
    var numberOfRow = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        //let v = UIView()
        //v.backgroundColor = UIColor.clear
        //tableView.tableFooterView = v
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
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
        case 4:
            cell.label1.text = label5
            cell.value1.text = value5
        case 5:
            cell.label1.text = label6
            cell.value1.text = value6
        case 6:
            cell.label1.text = label7
            cell.value1.text = value7
        case 7:
            cell.label1.text = label8
            cell.value1.text = value8
        case 8:
            cell.label1.text = label9
            cell.value1.text = value9
        case 9:
            cell.label1.text = label10
            cell.value1.text = value10
        case 10:
            cell.label1.text = label11
            cell.value1.text = value11
        case 11:
            cell.label1.text = label12
            cell.value1.text = value12
        case 12:
            cell.label1.text = label13
            cell.value1.text = value13
        case 13:
            cell.label1.text = label14
            cell.value1.text = value14
        case 14:
            cell.label1.text = label15
            cell.value1.text = value15
        default: break
        }
        return cell
    }

}
