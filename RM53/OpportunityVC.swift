//
//  OpportunityVC.swift
//  RM53
//
//  Created by Ayu on 6/28/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OpportunityVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var opportunities : [[String:String]] = [
        ["relationship":"ODW Logistics","targetDate":"07/30/2017", "salesStage":"02-Opportunity", "balance":"$7,500"],
        ["relationship":"ODW Logistics","targetDate":"06/30/2017", "salesStage":"02-Opportunity", "balance":"$17,500"],
        ["relationship":"ODW Logistics","targetDate":"08/30/2017", "salesStage":"02-Opportunity", "balance":"$117,500"],
        ["relationship":"ODW Logistics","targetDate":"09/30/2017", "salesStage":"02-Opportunity", "balance":"$7,800"],
        ["relationship":"ODW Logistics","targetDate":"10/30/2017", "salesStage":"02-Opportunity", "balance":"$17,600"],
        ["relationship":"ODW Logistics","targetDate":"11/30/2017", "salesStage":"02-Opportunity", "balance":"$17,300"],
        ["relationship":"ODW Logistics","targetDate":"06/30/2017", "salesStage":"02-Opportunity", "balance":"$71,500"],
        ["relationship":"ODW Logistics","targetDate":"05/30/2017", "salesStage":"02-Opportunity", "balance":"$75,500"]
    ]
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier1 = "opportunityCell1"
    let cellIdentifier2 = "opportunityCell1"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.isScrollEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return opportunities.count
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
            cell.relationship.text = opportunities[indexPath.row]["relationship"]
            cell.targetDate.text = opportunities[indexPath.row]["targetDate"]
            cell.salesStage.text = opportunities[indexPath.row]["salesStage"]
            cell.balance.text = opportunities[indexPath.row]["balance"]
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
    
        
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit Opportunity") { action, index in
            let editableItem1 = self.opportunities[indexPath.row]["targetDate"]
            let editableItem2 = self.opportunities[indexPath.row]["salesStage"]
            self.editButtonTapped(text1: editableItem1!,text2: editableItem2! ,index:indexPath.row)
        }
        edit.backgroundColor = UIColor.orange
        
        return [edit]
        
    }
    
    func editButtonTapped(text1:String, text2: String, index:Int){
        let alertController = UIAlertController(title: "Edit Opportunity", message: "", preferredStyle: .alert)

        let backView = alertController.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.orange
        
        let titleString  = "Edit Opportunity"
        var titleMutableString = NSMutableAttributedString()
        titleMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
        titleMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:0,length:titleString.characters.count))
        alertController.setValue(titleMutableString, forKey: "attributedTitle")
        
//        let message  = "Edit Open Opportunity"
//        var messageMutableString = NSMutableAttributedString()
//        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
//        messageMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:0,length:message.characters.count))
//        alertController.setValue(messageMutableString, forKey: "attributedMessage")
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            self.opportunities[index]["targetDate"] = firstTextField.text!
            self.opportunities[index]["salesStage"] = secondTextField.text!
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = text1
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = text2
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    
}
