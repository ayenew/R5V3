//
//  OpportunityDataEntryVC.swift
//  RM53
//
//  Created by Ayu on 8/16/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OpportunityDataEntryVC: UIViewController, UITextFieldDelegate {
    let targets = ["Opportunity","Pending Action","Won/Closed","Discovery","Proposal/Presentation","Client Commitmnet/Mandate","Lost"]
    var isDateCellHidden = true
    var isTargetCellHidden = true
    @IBOutlet weak var tableView: UITableView!
    var targetDate = String()
    var balance = String()
    var salesStage = String()
    
    var updatedTargetDate = String()
    var updatedBalance = String()
    var updatedSalesStage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

}

extension OpportunityDataEntryVC: UITableViewDataSource, UITableViewDelegate, DataTransferDelegate, DatePickerUpdateDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func cancelChange() {
        self.dismiss(animated: true, completion: nil)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = DataEntryCell()
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell0") as! DataEntryCell
            cell.salesTarget.text = salesStage
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DataEntryCell
            cell.SalesStagePicker.delegate = self
            cell.SalesStagePicker.dataSource = self
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! DataEntryCell
            cell.balance.text = balance
            cell.balance.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.balance.delegate = self
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! DataEntryCell
            cell.targetDate.text = targetDate
            //cell.dataTransferDelegate = self
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! DataEntryCell
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as! DataEntryCell
        default:
            return UITableViewCell()
        }
        cell.dataTransferDelegate = self
        cell.datePickerUpdateDelegate = self
        return cell
            
        }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isTargetCellHidden && indexPath.row == 1 {
            return 0
        } else if !isTargetCellHidden && indexPath.row == 1 {
            return 100
        } else if isDateCellHidden && indexPath.row == 4 {
            return 0
        } else if !isDateCellHidden && indexPath.row == 4 {
            return 100
        }
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            toggleDatePicker()
        }
        else if indexPath.row == 0 {
            toggleTargetPicker()
        }

    }
    
    func dateChanged(salesTarget: String){
        let index = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: index!) as! DataEntryCell
        cell.targetDate.text = salesTarget
        updatedTargetDate = cell.targetDate.text!
    }
    
    func toggleDatePicker(){
        isDateCellHidden = !isDateCellHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTargetPicker(){
        isTargetCellHidden = !isTargetCellHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func passData(){
        self.dismiss(animated: true, completion: nil)
        let bal = updatedBalance == "" ? balance : updatedBalance
        let td = updatedTargetDate == "" ? targetDate : updatedTargetDate
        let ss = updatedSalesStage == "" ? salesStage : updatedSalesStage
        let newOpportunity:[String:String] = ["salesTarget": ss,"balance": bal,"targetDate": td]
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "UpdateOpportunity"), object: nil, userInfo: newOpportunity)
    }
    
    func updateDatePicker(newDate: String) {
        dateChanged(salesTarget: newDate)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return targets[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.text = targets[row]
        label.textAlignment = .center
        return label
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTarget(newTarget: row)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return targets.count
    }
    
    func updateTarget(newTarget: Int){
        let index = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: index!) as! DataEntryCell
        cell.salesTarget.text = targets[newTarget]
        updatedSalesStage = cell.salesTarget.text!
    }
    
    func textFieldDidChange(_ newBalance: UITextField){
        updatedBalance = newBalance.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    
}
