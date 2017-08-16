//
//  ReportTVC.swift
//  RM53
//
//  Created by Ayu on 8/14/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ReportTVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = "Industry"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportRepo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = (reportRepo[indexPath.row]["name"] as! String)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegue(withIdentifier: "show_detail_segue_id_1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail_segue_id_1" {
            let vc = segue.destination as!  UINavigationController
            let targetController = vc.topViewController as! ReportDetailVC
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                targetController.industry = reportRepo[selectedRowIndexPath.row] 
            } else{
                    targetController.industry = reportRepo[0]
                
            }
        }
    }
}
