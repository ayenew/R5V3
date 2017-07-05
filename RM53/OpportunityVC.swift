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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }
        if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let color: UIColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        if indexPath.section == 0{
            let cell: OpportunityCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1) as! OpportunityCell
            cell.relationship.text = "ODW Logistics"
            cell.targetDate.text = "06/30/2017"
            cell.salesStage.text = "02-Opportunity"
            cell.balance.text = "$7,500"
            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2)
            cell?.textLabel?.text = "Show More"
            cell?.textLabel?.textColor = color
            return cell!
        }
        
        return UITableViewCell()
      
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
    }
    
}
