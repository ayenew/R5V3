//
//  OverViewTVC.swift
//  RM53
//
//  Created by Ayu on 7/30/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverViewTVC: UITableViewController {
    var company : [[String:String]] = [["Name": "odw Logistic Relationship","FirstName":"Cortney","LastName":"Biegler","Cell":"202-202-2000","Work":"210-210-2000"],
         ["Name": "Advanced Drainage Systems Inc","FirstName":"Scott","LastName":"Cottrill","Cell":"202-202-2000","Work":"210-210-2000"],
         ["Name": "Bankinsurance Corporation Relationship","FirstName":"Mathew","LastName":"Nolan","Cell":"202-202-2000","Work":"210-210-2000"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        // navigationController?.navigationBar.barTintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 0.3)
        navigationController?.navigationBar.barTintColor = UIColor(red: 51/255.0, green: 74/255.0, blue: 157/255.0, alpha: 0.2)
         self.navigationItem.title = "Contacts"
         self.tableView.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.tableFooterView = UIView()
    }
    
    func addItem(){
        let item = ["Name": "ABC Relationship","FirstName":"John","LastName":"Doe","Cell":"202-202-2000","Work":"210-210-2000"]
        company.append(item)
        let indexPath = IndexPath(row: company.count-1, section: 0)
        //tableView.beginUpdates()
        //self.tableView.insertRows(at: [indexPath], with: .automatic)
        //tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return company.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return company.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = company[section]
        return item["Name"]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OverViewCell
        let item = company[indexPath.row] 
        cell.firstName.text = item["FirstName"]!
        cell.lastName.text = item["LastName"]!
        cell.cellPhone.text = "Cell: \(item["Cell"]!)"
        cell.workPhone.text = "Work: \(item["Cell"]!)"

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //company.remove(at: indexPath.row)
            //tableView.beginUpdates()
            //tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
