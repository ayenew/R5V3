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
        catagorizedDetails = alertAndNotifs.groupBy(key: "notifType")
        notifs = Array(catagorizedDetails.keys)
       // self.tableView.register(UINib(nibName: "NotifCell", bundle: nil), forCellReuseIdentifier: "cell")
        //print(notifs)
//        sectionTitle.text = (alertAndNotifs["notifType"] as! String)
//        label1.text = alertAndNotifs["accountType"] as? String
//        label2.text = alertAndNotifs["date"] as? String
//        if alertAndNotifs["notifType"] as! String == "Delinquency" {
//            label3.text = alertAndNotifs["pastDueAmount"] as? String
//            label4.text = alertAndNotifs["daysPastDue"] as? String
//        } else if alertAndNotifs["notifType"] as! String == "Change in Balanace - Deposit" {
//            label3Title.text = "Segment"
//            label3.text = alertAndNotifs["segment"] as? String
//            label4Title.text = "Change Amount"
//            label4.text = alertAndNotifs["changeAmount"] as? String
//        } else if alertAndNotifs["notifType"] as! String == "Change in Balanace - Loan" {
//            label3Title.text = "Segment"
//            label3.text = alertAndNotifs["segment"] as? String
//            label4Title.text = "Change Amount"
//            label4.text = alertAndNotifs["changeAmount"] as? String
//        }
//        else if alertAndNotifs["notifType"] as! String == "Service Request - SLA Exceeded" {
//            label3Title.text = "Segment"
//            label3.text = alertAndNotifs["segment"] as? String
//            label4Title.text = "Days Past SLA"
//            label4.text = alertAndNotifs["daysPastSLA"] as? String
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return notifs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (catagorizedDetails[notifs[section]] as! [Any]).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotifCell

         //cell.textLabel?.text = alertAndNotifs[indexPath.row]["accountType"] as? String
        let items = catagorizedDetails[notifs[indexPath.section]] as! [[String:String]]
        print(indexPath.row, items.count)
        //cell.textLabel?.text = items[indexPath.row]["accountType"]
       // cell.date.text = items[indexPath.row]["date"]
        cell.accountType.text = items[indexPath.row]["accountType"]
        //cell.eid.text = items[indexPath.row]["eid"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return notifs[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.showView(indexPath: indexPath)
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    func showView(indexPath : IndexPath){
        let fromRect:CGRect = self.tableView.rectForRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Notification", bundle: nil)
        let popoverVC = storyboard.instantiateViewController(withIdentifier: "popover")
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: self.view.frame.width * 0.9, height: 300)
        popoverVC.view.backgroundColor = UIColor.lightGray
        present(popoverVC, animated: true, completion: nil)
        let popoverController = popoverVC.popoverPresentationController
        popoverController!.sourceView = self.view
        popoverController!.sourceRect = fromRect
        popoverController!.permittedArrowDirections = .any
    }
 
//    func showView(){
//        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 300))
//        v.backgroundColor = UIColor.gray
//        v.center = view.center
//        v.alpha = 0
//        view.addSubview(v)
//        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
//            
//            v.alpha = 1
//            
//        }, completion: nil)
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
