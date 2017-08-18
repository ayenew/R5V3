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
        cell.accountNumber.text = items[indexPath.row]["accountNumber"]
            //(items[indexPath.row]["accountNumber"] != "")
            //?items[indexPath.row]["accountNumber"] : items[indexPath.row]["eid"]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return notifs[section]
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setSectionHeader(title: notifs[section])
    }
    
    func setSectionHeader(title: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        headerView.backgroundColor = UIColor.groupTableViewBackground
        let titleLbl = UILabel(frame: CGRect(x: 8, y: 0, width: self.view.frame.width, height: 40))
        
        titleLbl.attributedText = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName : UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1), NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 18)!])
        headerView.addSubview(titleLbl)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.showView(indexPath: indexPath)
    }
    
    func showView(indexPath : IndexPath){
        let fromRect:CGRect = self.tableView.rectForRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Notification", bundle: nil)
        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popover") as! DetailViewTVC
        let items = catagorizedDetails[notifs[indexPath.section]] as! [[String:String]]
        
        popoverVC.label1 = "Account Number"
        popoverVC.value1 = items[indexPath.row]["accountNumber"]!
        popoverVC.label2 = "Date"
        popoverVC.value2 = items[indexPath.row]["date"]!
        popoverVC.label3 = "Segment"
        popoverVC.value3 = items[indexPath.row]["segment"]!
        let typeId = items[indexPath.row]["typeId"]!
        bindData(popoverVC: popoverVC, typeId: typeId, items: items, indexPath: indexPath)

        
        popoverVC.modalPresentationStyle = .popover
        popoverVC.modalTransitionStyle = .crossDissolve
        popoverVC.preferredContentSize = CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.6)
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController?.backgroundColor = UIColor(red: 85/255.0, green: 86/255.0, blue: 90/255.0, alpha: 0.5)
        popoverController!.sourceView = self.view
        popoverController!.sourceRect = fromRect
        popoverController!.permittedArrowDirections = .any
    }
    
    func bindData(popoverVC: DetailViewTVC, typeId:String, items: [[String:String]], indexPath: IndexPath) {
        switch typeId {
        case "1":
            popoverVC.label4 = "Days Past Due"
            popoverVC.value4 = items[indexPath.row]["daysPastDue"]!
            popoverVC.label5 = "Past Due Amount"
            popoverVC.value5 = items[indexPath.row]["pastDueAmount"]!
            popoverVC.label6 = "Interest Rate"
            popoverVC.value6 = items[indexPath.row]["interestRate"]!
            popoverVC.label7 = "Primary Contact"
            popoverVC.value7 = items[indexPath.row]["primaryContact"]!
            popoverVC.label8 = "Phone"
            popoverVC.value8 = items[indexPath.row]["phone"]!
            popoverVC.label9 = "Email"
            popoverVC.value9 = items[indexPath.row]["email"]!
            popoverVC.label10 = "Auto Bill Payer"
            popoverVC.value10 = items[indexPath.row]["autoBillPayer"]!
            popoverVC.label11 = "Bill Payer Account"
            popoverVC.value11 = items[indexPath.row]["billPayerAccount"]!
            popoverVC.label12 = "Bill Payer Account Balance"
            popoverVC.value12 = items[indexPath.row]["billPayerBalance"]!
            popoverVC.label13 = "Maturity Date"
            popoverVC.value13 = items[indexPath.row]["maturityDate"]!
            popoverVC.label14 = "Commitment Amount"
            popoverVC.value14 = items[indexPath.row]["commitmentAmount"]!
            popoverVC.numberOfRow = 14
        case "2","3":
            popoverVC.label4 = "Change Amount"
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
            popoverVC.label5 = "Primary Contact"
            popoverVC.value5 = items[indexPath.row]["primaryContact"]!
            popoverVC.label6 = "Phone"
            popoverVC.value6 = items[indexPath.row]["phone"]!
            popoverVC.label7 = "Email"
            popoverVC.value7 = items[indexPath.row]["email"]!
            popoverVC.label8 = "Previous Balance"
            popoverVC.value8 = items[indexPath.row]["previousBalance"]!
            popoverVC.label9 = "Available Balance"
            popoverVC.value9 = items[indexPath.row]["availableBalance"]!
            popoverVC.numberOfRow = 9
        case "4":
            popoverVC.label4 = "Days Past SLA"
            popoverVC.value4 = items[indexPath.row]["daysPastSLA"]!
            popoverVC.numberOfRow = 4
        case "5":
            popoverVC.label4 = "Days Past Due"
            popoverVC.value4 = items[indexPath.row]["daysPastDue"]!
            popoverVC.label5 = "Past Due amount"
            popoverVC.value5 = items[indexPath.row]["pastDueAmount"]!
            popoverVC.label5 = "Primary Contact"
            popoverVC.value5 = items[indexPath.row]["primaryContact"]!
            popoverVC.label6 = "Phone"
            popoverVC.value6 = items[indexPath.row]["phone"]!
            popoverVC.label7 = "Email"
            popoverVC.value7 = items[indexPath.row]["email"]!
            popoverVC.label8 = "Interest Rate"
            popoverVC.value8 = items[indexPath.row]["interestRate"]!
            popoverVC.label9 = "Auto Bill Payer"
            popoverVC.value9 = items[indexPath.row]["autoBillPayer"]!
            popoverVC.label10 = "Bill Payer Account"
            popoverVC.value10 = items[indexPath.row]["billPayerAccount"]!
            popoverVC.label11 = "Bill Payer Account Balance"
            popoverVC.value11 = items[indexPath.row]["billPayerBalance"]!
            popoverVC.label12 = "Outstanding Balance"
            popoverVC.value12 = items[indexPath.row]["outstandingBalance"]!
            popoverVC.label13 = "Commitment Amount"
            popoverVC.value13 = items[indexPath.row]["commitmentAmount"]!
            popoverVC.numberOfRow = 13
        case "6":
            popoverVC.label4 = "Change Amount"
            popoverVC.value4 = items[indexPath.row]["changeAmount"]!
            popoverVC.label5 = "Primary Contact"
            popoverVC.value5 = items[indexPath.row]["primaryContact"]!
            popoverVC.label6 = "Phone"
            popoverVC.value6 = items[indexPath.row]["phone"]!
            popoverVC.label7 = "Email"
            popoverVC.value7 = items[indexPath.row]["email"]!
            popoverVC.label8 = "No of Days OD"
            popoverVC.value8 = items[indexPath.row]["noOfDaysOD"]!
            popoverVC.label9 = "Days OD Last 12 Months"
            popoverVC.value9 = items[indexPath.row]["daysODLast12Months"]!
            popoverVC.label10 = "Times OD Last 12 Months"
            popoverVC.value10 = items[indexPath.row]["timesODLast12Months"]!
            popoverVC.numberOfRow = 10
        case "7":
            popoverVC.label4 = "Commitment Amount"
            popoverVC.value4 = items[indexPath.row]["commitmentAmount"]!
            popoverVC.label5 = "Primary Contact"
            popoverVC.value5 = items[indexPath.row]["primaryContact"]!
            popoverVC.label6 = "Phone"
            popoverVC.value6 = items[indexPath.row]["phone"]!
            popoverVC.label7 = "Email"
            popoverVC.value7 = items[indexPath.row]["email"]!
            popoverVC.label8 = "Portfolio Manager"
            popoverVC.value8 = items[indexPath.row]["portfolioManager"]!
            popoverVC.label9 = "Origination Date"
            popoverVC.value9 = items[indexPath.row]["originationDate"]!
            popoverVC.label10 = "Outstanding Balance"
            popoverVC.value10 = items[indexPath.row]["outstandingBalance"]!
            popoverVC.label11 = "PD Rating"
            popoverVC.value11 = items[indexPath.row]["pdRating"]!
            popoverVC.label12 = "PD Date"
            popoverVC.value12 = items[indexPath.row]["pdDate"]!
            popoverVC.label13 = "Product"
            popoverVC.value13 = items[indexPath.row]["product"]!
            popoverVC.label14 = "Outstanding Balance"
            popoverVC.value14 = items[indexPath.row]["outstandingBalance"]!
            popoverVC.numberOfRow = 14
        default:
            break
        }
    }

}
