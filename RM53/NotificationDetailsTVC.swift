//
//  NotificationDetailsTVC.swift
//  RM53
//
//  Created by Ayu on 8/11/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class NotificationDetailsTVC: UITableViewController {
    var catagorizedDetails = [String:Any]()
    var notifs = [String]()
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label3Title: UILabel!
    @IBOutlet weak var label4Title: UILabel!
    
    var alertAndNotifs = [[String:Any]]()
    var pageTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = pageTitle
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView.tableFooterView = UIView()
        catagorizedDetails = alertAndNotifs.groupBy(key: "type")
        notifs = Array(catagorizedDetails.keys)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return notifs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (catagorizedDetails[notifs[section]] as! [Any]).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotifCell
        let items = catagorizedDetails[notifs[indexPath.section]] as! [[String:String]]
        cell.accountType.text = items[indexPath.row]["accountType"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return notifs[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.showView(indexPath: indexPath)
    }
    
    func showView(indexPath : IndexPath){
        let fromRect:CGRect = self.tableView.rectForRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Notification", bundle: nil)
        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popover") as! DetailViewTVC
        let items = catagorizedDetails[notifs[indexPath.section]] as! [[String:String]]
        
        popoverVC.label1 = "EID"
        popoverVC.value1 = items[indexPath.row]["eid"]!
        popoverVC.label2 = "Date"
        popoverVC.value2 = items[indexPath.row]["date"]!

        let type = items[indexPath.row]["type"]!
        if type == "Delinquency" {
            popoverVC.label3 = "Past Due Amount"
            popoverVC.label4 = "Days Past Due"
            popoverVC.value3 = items[indexPath.row]["pastDueAmount"]!
            popoverVC.value4 = items[indexPath.row]["daysPastDue"]!
        } else if type == "Change in Balanace - Deposit" {
            popoverVC.label3 = "Segment"
            popoverVC.label4 = "Change Amount"
            popoverVC.value3 = items[indexPath.row]["segment"]!
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
        } else if type == "Change in Balanace - Loan" {
            popoverVC.label3 = "Segment"
            popoverVC.label4 = "Change Amount"
            popoverVC.value3 = items[indexPath.row]["segment"]!
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
        }
        else if type == "Service Request - SLA Exceeded" {
            popoverVC.label3 = "Segment"
            popoverVC.label4 = "Days Past SLA"
            popoverVC.value3 = items[indexPath.row]["segment"]!
            popoverVC.value4 = items[indexPath.row]["daysPastSLA"]!
        }
        
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: self.view.frame.width * 0.9, height: 300)
        popoverVC.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.05)
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        popoverController!.sourceView = self.view
        popoverController!.sourceRect = fromRect
        popoverController!.permittedArrowDirections = .any
    }

}
