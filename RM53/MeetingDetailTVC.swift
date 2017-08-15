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
    var addButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    var isCellHidden = true
    var isCallReportActive = true
    var meetings = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callReportLbl.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = meetings["company"]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        saveButton = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveItem))
        
        addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addItem))
        
         editButton = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: #selector(editItem))
        updateRow()
        if callReportLbl.text != "" {
            isCellHidden = false
            saveButton.isEnabled = false
            editButton.isEnabled = true
            addButton.isEnabled = false
            callReportLbl.isEditable = false
        } else{
            isCellHidden = true
            saveButton.isEnabled = false
            editButton.isEnabled = false
            addButton.isEnabled = true
        }
        self.navigationItem.rightBarButtonItems = [editButton,addButton,saveButton]
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
        
    }
    
    func updateRow(){
        companyLbl.text = meetings["company"]
        callPlanLbl.text = meetings["callPlaneName"]
        reasonLbl.text = meetings["reason"]
        //detailLbl.text = meetings["details"]
        //detailLbl.sizeToFit()
        callReportLbl.text = meetings["details"]
        callReportLbl.sizeToFit()
    }
    
    func addItem(){
        isCellHidden = false
        isCallReportActive = true
        callReportLbl.isEditable = true
        callReportLbl.becomeFirstResponder()
        callReportLbl.sizeToFit()
        saveButton.isEnabled = true
        editButton.isEnabled = true
        addButton.isEnabled = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func saveItem(){
        if callReportLbl.text == "" {
            isCellHidden = true
            isCallReportActive = false
            saveButton.isEnabled = false
            editButton.isEnabled = false
        } else{
            isCellHidden = false
            isCallReportActive = false
            saveButton.isEnabled = true
            editButton.isEnabled = true
        }
        
        callReportLbl.isEditable = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func editItem(){
        //self.setEditing(true, animated: true)
        if isCellHidden == false && callReportLbl.text != "" {
            callReportLbl.isEditable = true
            saveButton.isEnabled = true
            callReportLbl.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 && isCellHidden {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
//
//        if indexPath.row == 3 {
//            
//        }
//
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
