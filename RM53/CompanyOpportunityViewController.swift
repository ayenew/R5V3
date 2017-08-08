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
    var opportunities : [[String:String]] = [
        ["relationship":"odw Logistic Relationship","targetDate":"07/30/2017", "salesStage":"02-Opportunity", "balance":"$7,500"],
        ["relationship":"Advanced Drainage Systems Inc.","targetDate":"06/30/2017", "salesStage":"02-Opportunity", "balance":"$17,500"],
        ["relationship":"Bancinsurance Corporation Ralationship","targetDate":"08/30/2017", "salesStage":"02-Opportunity", "balance":"$117,500"],
        ["relationship":"Bancinsurance Corporation Ralationship","targetDate":"08/30/2017", "salesStage":"02-Opportunity", "balance":"$117,500"],
        ["relationship":"Bancinsurance Corporation Ralationship","targetDate":"08/30/2017", "salesStage":"02-Opportunity", "balance":"$117,500"]
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier1 = "cell"
    //let cellIdentifier2 = "opportunityCell1"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "OpportunityCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
        self.navigationItem.title = "Open Opportunities"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 44/255.0, green: 82/255.0, blue: 231/255.0, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
       // self.tableView.tableFooterView = UIView()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return opportunities.count
//        }
//        if section == 1 {
//            return 1
//        }
       return opportunities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let color: UIColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        //if indexPath.section == 0{
            let cell: OpportunityCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1) as! OpportunityCell
            cell.relationship.text = opportunities[indexPath.row]["relationship"]
            cell.targetDate.text = opportunities[indexPath.row]["targetDate"]
            cell.salesStage.text = opportunities[indexPath.row]["salesStage"]
            cell.balance.text = opportunities[indexPath.row]["balance"]
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.white
            }
            return cell
        //}
//        if indexPath.section == 1{
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2)
//            cell?.textLabel?.text = "Show More"
//            cell?.textLabel?.textColor = color
//            cell?.textLabel?.textAlignment = .center
//            return cell!
//        }
        
       // return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 {
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
                let editableItem1 = self.opportunities[indexPath.row]["targetDate"]
                let editableItem2 = self.opportunities[indexPath.row]["salesStage"]
                let editableItem3 = self.opportunities[indexPath.row]["balance"]
                self.editButtonTapped(text1: editableItem1!,text2: editableItem2! ,text3: editableItem3!,index:indexPath.row)
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

//    override func viewDidAppear(_ animated: Bool) {
//        
//        //chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
//        chartView.layers = [createPlainTextLayer()]
//        chartView.delegate = self
//        chartView.models = createModels() // order is important - models have to be set at the end
//        
//        chartView.layers = [createPlainTextLayer()]
//        chartView.delegate = self
//        chartView.models = createModels()
//        
//        chartView.layers = [createPlainTextLayer()]
//        chartView.delegate = self
//        chartView.models = createModels()
//    }
//    
//    // MARK: - PieChartDelegate
//    
//    func onSelected(slice: PieSlice, selected: Bool) {
//        print("Selected: \(selected), slice: \(slice)")
//    }
    
    // MARK: - Models
    
    
//    fileprivate func createModels() -> [PieSliceModel] {
//        let models = [
//            PieSliceModel(value: 45.6e3, color: colors[4], name: "TM Exposure"),
//            PieSliceModel(value: 55e3, color: colors[5], name: "CM Exposure"),
//            PieSliceModel(value: 30e3, color: colors[6], name: "Credit Exposure"),
//            PieSliceModel(value: 20e3, color: colors[7], name: "Deposit Exposure"),
//            ]
//        var total = 0.0
//        for model in models {
//            total += model.value
//        }
//        
//        //totalRevenue.text = "$\(total/1000)k"
//        
//        currentColorIndex = models.count
//        return models
//    }
    
    // MARK: - Layers
//    
//    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
//        
//        let textLayerSettings = PiePlainTextLayerSettings()
//        textLayerSettings.viewRadius = 55
//        textLayerSettings.hideOnOverflow = true
//        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
//        
//        let formatter = NumberFormatter()
//        formatter.maximumFractionDigits = 1
//        textLayerSettings.label.textGenerator = {slice in
//            return formatter.string(from: slice.data.model.value/1000 as NSNumber).map{"\($0)K"} ?? ""
//        }
//        
//        let textLayer = PiePlainTextLayer()
//        textLayer.settings = textLayerSettings
//        return textLayer
//    }


}
