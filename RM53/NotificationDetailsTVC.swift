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
        cell.accountNumber.text = (items[indexPath.row]["accountNumber"] != "") ?items[indexPath.row]["accountNumber"] : items[indexPath.row]["eid"]
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
        
        popoverVC.label1 = "EID or Account Number"
        popoverVC.value1 = items[indexPath.row]["eid"]!
        popoverVC.label2 = "Date"
        popoverVC.value2 = items[indexPath.row]["date"]!
        popoverVC.label3 = "Segment"
        popoverVC.value3 = items[indexPath.row]["segment"]!
        
        let typeId = items[indexPath.row]["typeId"]!
        switch typeId {
        case "1":
            popoverVC.label4 = "Days Past Due"
            popoverVC.value4 = items[indexPath.row]["daysPastDue"]!
            popoverVC.label5 = "Past Due Amount"
            popoverVC.value5 = items[indexPath.row]["pastDueAmount"]!
        case "2","3":
            popoverVC.label4 = "Change Amount"
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
        case "4":
            popoverVC.label4 = "Days Past SLA"
            popoverVC.value4 = items[indexPath.row]["daysPastSLA"]!
        case "5":
            popoverVC.label4 = "Days Past Due"
            popoverVC.value4 = items[indexPath.row]["daysPastDue"]!
            popoverVC.label5 = "Past Due amount"
            popoverVC.value5 = items[indexPath.row]["pastDueAmount"]!
        case "6":
            popoverVC.label4 = "Commitment Amount"
            popoverVC.value4 = items[indexPath.row]["commitmentAmount"]!
            popoverVC.label5 = "Product"
            popoverVC.value5 = items[indexPath.row]["product"]!
        case "7":
            popoverVC.label4 = "Change Amount"
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
        default:
            break
        }
        
        popoverVC.modalPresentationStyle = .popover
       // popoverVC.modalTransitionStyle = .crossDissolve
        popoverVC.preferredContentSize = CGSize(width: self.view.frame.width * 0.9, height: 300)
        popoverVC.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.05)
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController?.backgroundColor = UIColor(red: 27/255.0, green: 71/255.0, blue: 149/255.0, alpha: 0.5)
        popoverController!.sourceView = self.view
        popoverController!.sourceRect = fromRect
        popoverController!.permittedArrowDirections = .any
    }

}
