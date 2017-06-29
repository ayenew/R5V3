//
//  OpportunityVC.swift
//  RM53
//
//  Created by Ayu on 6/28/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OpportunityVC: UIViewController,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier1 = "opportunityCell1"
    let cellIdentifier2 = "opportunityCell1"
    let cellIdentifier3 = "opportunityCell1"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        if section == 1 {
            return 5
        }
        if section == 2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1)
            cell?.textLabel?.text = "Opprtunity"
            cell?.detailTextLabel?.text = "5 Open"
            cell?.textLabel?.textColor = UIColor.blue
            cell?.detailTextLabel?.textColor = UIColor.blue
        }
        if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2)
            cell?.textLabel?.text = "Opprtunity   2"
            cell?.textLabel?.textColor = UIColor.blue
            cell?.detailTextLabel?.textColor = UIColor.blue
        }
        if indexPath.section == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2)
            cell?.textLabel?.text = "Opprtunity   3"
            cell?.textLabel?.textColor = UIColor.blue
            cell?.detailTextLabel?.textColor = UIColor.blue
        }
        
        return cell!
    }
}
