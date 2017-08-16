//
//  MeetingDetailTVC.swift
//  RM53
//
//  Created by Ayu on 8/9/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class MeetingDetailTVC: UITableViewController, UITextViewDelegate {
    @IBOutlet weak var companyLbl: UILabel!
    
    @IBOutlet weak var callPlanLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    
    @IBOutlet weak var callReportLbl: UITextView!
    @IBOutlet weak var detailLbl: UILabel!
    
    var saveButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    var meetings = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callReportLbl.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = meetings["company"]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        saveButton = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveItem))
        
         editButton = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: #selector(editItem))
        updateRow()
        saveButton.isEnabled = false
        editButton.isEnabled = true
        callReportLbl.isEditable = false
        self.navigationItem.rightBarButtonItems = [editButton,saveButton]
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
        
    }
    
    func updateRow(){
        companyLbl.text = meetings["company"]
        callPlanLbl.text = meetings["callPlaneName"]
        reasonLbl.text = meetings["reason"]
        callReportLbl.text = meetings["details"]
        callReportLbl.sizeToFit()
    }

    func saveItem(){
        saveButton.isEnabled = false
        editButton.isEnabled = true
        callReportLbl.isEditable = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func editItem(){
        callReportLbl.isEditable = true
        callReportLbl.becomeFirstResponder()
        //callReportLbl.sizeToFit()
        editButton.isEnabled = false
        saveButton.isEnabled = true
    }
    
}
