//
//  NotificationTVC.swift
//  RM53
//
//  Created by Ayu on 8/11/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewController {
    var catagorizedNotif = [String:Any]()
    var notifs = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = "Companies"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //getSections()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabbbarController = appDelegate.window!.rootViewController as! UITabBarController
        let vc = tabbbarController.viewControllers?[3]
        vc?.tabBarItem.badgeValue = nil
        catagorizedNotif = alertNotifRepo.groupBy(key: "entity") 
        notifs = Array(catagorizedNotif.keys)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    func getSections(){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_segue_id_1" {
            let vc = segue.destination as!  UINavigationController
            let targetController = vc.topViewController as! NotificationDetailsTVC
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
               // targetController.alertAndNotifs = alertNotifRepo[selectedRowIndexPath.row]
                targetController.pageTitle = notifs[0]
                targetController.alertAndNotifs = catagorizedNotif[notifs[selectedRowIndexPath.row]] as! [[String : Any]]
            } else{
               // targetController.alertAndNotifs = alertNotifRepo[0]
                targetController.pageTitle = notifs[0]
                targetController.alertAndNotifs = catagorizedNotif[notifs[0]] as! [[String : Any]]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return alertNotifRepo.count
        return notifs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //.textLabel?.text = alertNotifRepo[indexPath.row]["entity"] as! String?
        cell.textLabel?.text = notifs[indexPath.row] 
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }

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

extension Sequence where Iterator.Element == [String: Any]{
    public func groupBy(key: String) -> [String: Any]{
        let keys = self.flatMap{($0[key] as! String)}
        let tempSet = Set<String>(keys)
        let uniqueKeys = Array(tempSet)
        var result = [String: Any]()
        for item in uniqueKeys{
            let arrFilter = self.filter({
                $0[key] as! String == item
            })
            result[item] = arrFilter as Any
        }
        return result
    }
}
