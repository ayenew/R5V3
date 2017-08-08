//
//  OverViewTVC.swift
//  RM53
//
//  Created by Ayu on 7/30/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverViewTVC: UITableViewController {
    var company : [String:String] = ["Name": "odw Logistic Relationship","PFirstName":"Cortney","PLastName":"Biegler","PCell":"202-202-2000","PWork":"210-210-2000","SFirstName":"Scott","SLastName":"Cottrill","SCell":"202-202-2000","SWork":"210-210-2000","TFirstName":"Mathew","TLastName":"Nolan","TCell":"202-202-2000","TWork":"210-210-2000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
         let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationItem.rightBarButtonItems = [self.editButtonItem,addButton]
        // navigationController?.navigationBar.barTintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 0.3)
//        navigationController?.navigationBar.barTintColor = UIColor(red: 51/255.0, green: 74/255.0, blue: 157/255.0, alpha: 0.2)
        navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
         self.navigationItem.title = "Contacts"
         self.tableView.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 44/255.0, green: 82/255.0, blue: 231/255.0, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
        self.tableView.tableFooterView = UIView()
    }
    
    func setupMap(){
        
    }
    
    func addItem(){
       // let item = ["Name": "ABC Relationship","FirstName":"John","LastName":"Doe","Cell":"202-202-2000","Work":"210-210-2000"]
        //company.append(item)
       // let indexPath = IndexPath(row: company.count-1, section: 0)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let item = company[section]
//        return item["Name"]
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OverViewCell
        //let item = company[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.firstName.text = company["PFirstName"]!
            cell.firstName.text = company["PFirstName"]!
            cell.lastName.text = company["PLastName"]!
            cell.cellPhone.text = "Cell: \(company["PCell"]!)"
            cell.workPhone.text = "Work: \(company["PWork"]!)"
        case 1:
            cell.firstName.text = company["SFirstName"]!
            cell.firstName.text = company["SFirstName"]!
            cell.lastName.text = company["SLastName"]!
            cell.cellPhone.text = "Cell: \(company["SCell"]!)"
            cell.workPhone.text = "Work: \(company["SWork"]!)"
        case 2:
            cell.firstName.text = company["TFirstName"]!
            cell.firstName.text = company["TFirstName"]!
            cell.lastName.text = company["TLastName"]!
            cell.cellPhone.text = "Cell: \(company["TCell"]!)"
            cell.workPhone.text = "Work: \(company["TWork"]!)"
        default: break
        }
        
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
