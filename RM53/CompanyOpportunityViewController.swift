//
//  CompanyOpportunityViewController.swift
//  RM53
//
//  Created by Ayu on 7/29/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
//import PieCharts

class CompanyOpportunityViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var opportunities = [[String:String]]()
    var selectedIndex = Int()
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier1 = "OpportunityCell2"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "OpportunityCell2", bundle: nil), forCellReuseIdentifier: "OpportunityCell2")
        
        navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
        self.navigationItem.title = "Opportunities"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
       // self.tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateOpportunity), name: NSNotification.Name.init(rawValue: "UpdateOpportunity"), object: nil)
    }
    
    func updateOpportunity(_ notification: NSNotification) {
        if let target = notification.userInfo as? [String:String] {
            self.opportunities[selectedIndex]["targetDate"] = target["targetDate"]
            self.opportunities[selectedIndex]["salesStage"] = target["salesTarget"]
            self.opportunities[selectedIndex]["balance"] = target["balance"]
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return opportunities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: OpportunityCell2 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1) as! OpportunityCell2
            //cell.relationship.text = opportunities[indexPath.row]["name"]
            cell.targetDate.text = opportunities[indexPath.row]["targetDate"]
            cell.salesStage.text = opportunities[indexPath.row]["salesStage"]
            cell.balance.text = opportunities[indexPath.row]["balance"]
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
                let editableItem1 = self.opportunities[indexPath.row]["targetDate"]
                let editableItem2 = self.opportunities[indexPath.row]["salesStage"]
                let editableItem3 = self.opportunities[indexPath.row]["balance"]
                //self.editButtonTapped(text1: editableItem1!,text2: editableItem2! ,text3: editableItem3!,index:indexPath.row)
                self.openEditWindow(indexPath:indexPath, editableItem1: editableItem1!, editableItem2: editableItem2!, editableItem3: editableItem3!)
            }
            edit.backgroundColor = UIColor.orange
            
            return [edit]
        }
        return nil
    }
    
    func editButtonTapped(text1:String, text2: String, text3: String, index:Int){
        let alertController = UIAlertController(title: "Enter the new Target Date & Sales Stage", message: "", preferredStyle: .alert)
        
        let titleString  = "Enter the new Target Date Sales Stage and/or Balance"
        var titleMutableString = NSMutableAttributedString()
        titleMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 18.0)!])
        titleMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 44/255.0, green: 82/255.0, blue: 231/255.0, alpha: 1), range: NSRange(location:0,length:titleString.characters.count))
        alertController.setValue(titleMutableString, forKey: "attributedTitle")
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            let thirdTextField = alertController.textFields![1] as UITextField
            self.opportunities[index]["targetDate"] = firstTextField.text!
            self.opportunities[index]["salesStage"] = secondTextField.text!
            self.opportunities[index]["balance"] = thirdTextField.text!
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = text1
            textField.textColor = UIColor.black
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.tag = 1000
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = text2
            textField.textColor = UIColor.black
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.tag = 2000
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = text3
            textField.textColor = UIColor.black
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.tag = 3000
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.view.layer.cornerRadius = 12.0
        alertController.view.backgroundColor = UIColor.darkGray
        alertController.view.layer.masksToBounds = true
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1000 || textField.tag == 2000 || textField.tag == 3000{
            textField.tag = 0
            return false
        } else{
            return true
        }
    }
    
    func openEditWindow(indexPath:IndexPath, editableItem1: String, editableItem2: String, editableItem3: String){
        let fromRect:CGRect = self.tableView.rectForRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Opportunity", bundle: nil)
        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popover") as! OpportunityDataEntryVC
        
        popoverVC.targetDate = editableItem1
        popoverVC.salesStage = editableItem2
        popoverVC.balance = editableItem3
        
        popoverVC.modalPresentationStyle = .popover
        popoverVC.modalTransitionStyle = .crossDissolve
        popoverVC.preferredContentSize = CGSize(width: self.view.frame.width * 0.6, height: 400)
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController?.backgroundColor = UIColor(red: 85/255.0, green: 86/255.0, blue: 90/255.0, alpha: 0.5)
        popoverController!.sourceView = self.view
        popoverController!.sourceRect = fromRect
        popoverController!.permittedArrowDirections = .any
    }
    
}
