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
    var searchBarText = ""
    let searchController = UISearchController(searchResultsController: nil)
    var filteredNotifs = [String]()
    
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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSearchText), name: NSNotification.Name.init(rawValue: "UpdateSearchText"), object: nil)
        
    }
    
    func updateSearchText(_ notification: NSNotification) {
        
        if let company = notification.userInfo as? [String:String] {
            let text = company["name"]!
            self.searchController.isActive = true
            self.searchController.searchBar.text = text
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    func getSections(){
        //searchController.searchBar.text =
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_segue_id_1" {
            let vc = segue.destination as!  UINavigationController
            let targetController = vc.topViewController as! NotificationDetailsTVC
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                if searchController.isActive && searchController.searchBar.text != "" {
                    targetController.pageTitle = filteredNotifs[selectedRowIndexPath.row]
                    targetController.alertAndNotifs = catagorizedNotif[filteredNotifs[selectedRowIndexPath.row]] as! [[String : Any]]
                }else{
                    targetController.pageTitle = notifs[selectedRowIndexPath.row]
                    targetController.alertAndNotifs = catagorizedNotif[notifs[selectedRowIndexPath.row]] as! [[String : Any]]
                }
            } else{
                if searchController.isActive && searchController.searchBar.text != "" {
                    targetController.pageTitle = filteredNotifs[0]
                    targetController.alertAndNotifs = catagorizedNotif[filteredNotifs[0]] as! [[String : Any]]
                } else{
                    targetController.pageTitle = notifs[0]
                    targetController.alertAndNotifs = catagorizedNotif[notifs[0]] as! [[String : Any]]
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
           return filteredNotifs.count
        }
        return notifs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredNotifs[indexPath.row]
        } else {
            cell.textLabel?.text = notifs[indexPath.row]
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }

}

extension NotificationTVC:UISearchBarDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredNotifs = notifs.filter({
            nil != $0.lowercased().range(of:searchController.searchBar.text!.lowercased())
        })
        tableView.reloadData()
    }
    
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
