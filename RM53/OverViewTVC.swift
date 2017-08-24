//
//  OverViewTVC.swift
//  RM53
//
//  Created by Ayu on 7/30/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverViewTVC: UITableViewController, UITextFieldDelegate {
    var contacts = [[String:String]]()
    var primaryContact = [String:String]()
    var secondaryContact = [String:String]()
    var newContact = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
         let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationItem.rightBarButtonItems = [self.editButtonItem,addButton]
        navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
         self.navigationItem.title = "Contacts"
         self.tableView.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
        self.tableView.tableFooterView = UIView()
    }
    
    func setupMap(){
        
    }
    
    func addItem(){
        DispatchQueue.main.async {
            self.getNewContact()
        }
    }
    
    func getNewContact() {
        let alertController = UIAlertController(title: "Add New Contact", message: "", preferredStyle: .alert)
        
        let titleString  = "Add New Contact"
        var titleMutableString = NSMutableAttributedString()
        titleMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 18.0)!])
        titleMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 44/255.0, green: 82/255.0, blue: 231/255.0, alpha: 1), range: NSRange(location:0,length:titleString.characters.count))
        alertController.setValue(titleMutableString, forKey: "attributedTitle")
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            let thirdTextField = alertController.textFields![2] as UITextField
            if (firstTextField.text! == "" || secondTextField.text! == "" || thirdTextField.text! == "") {
                let alertController = UIAlertController(title: "Adding Contact Failed", message: "All fields are required. Please provide all the fields", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.newContact["firstName"] = firstTextField.text!
                self.newContact["lastName"] = secondTextField.text!
                self.newContact["cellPhone"] = thirdTextField.text!
                self.newContact["secondPhone"] = thirdTextField.text!
                self.contacts.append(self.newContact)
                
                let indexPath = IndexPath(row: self.contacts.count-1, section: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
                
                self.tableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "First Name"
            textField.textColor = UIColor.blue
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.tag = 1000
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Last Name"
            textField.textColor = UIColor.blue
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.tag = 2000
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Cell Phone"
            textField.textColor = UIColor.blue
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OverViewCell
        if indexPath.row == 0 {
            let item = contacts[indexPath.row]
            cell.lastName.text = "\(item["firstName"]!) \(item["lastName"]!)"
            cell.lastName.textColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
            cell.cellPhone.text = "Cell: \(item["cellPhone"]!)   Work: \(item["secondPhone"]!)"
            cell.cellPhone.textColor = UIColor(red: 0/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        } else {
            let item = contacts[indexPath.row]
            cell.lastName.text = "\(item["firstName"]!) \(item["lastName"]!)"
            cell.cellPhone.text = "Cell: \(item["cellPhone"]!)   Work: \(item["secondPhone"]!)"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            let newPrimarycontact:[String:String] = ["firstName": contacts[0]["firstName"]!,"lastName": contacts[0]["lastName"]!,"cellPhone": contacts[0]["cellPhone"]!,"secondPhone": contacts[0]["secondPhone"]!]
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "UpdatePrimaryContact"), object: nil, userInfo: newPrimarycontact)
        } else if editingStyle == .insert {
            let item = ["FirstName":"John","LastName":"Doe","Cell":"202-202-2000","Work":"210-210-2000"]
            contacts.append(item)
            let indexPath = IndexPath(row: contacts.count-1, section: 0)
            tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = contacts[fromIndexPath.row]
        contacts.remove(at: fromIndexPath.row)
        contacts.insert(itemToMove, at: to.row)
        let newPrimarycontact:[String:String] = ["firstName": contacts[0]["firstName"]!,"lastName": contacts[0]["lastName"]!,"cellPhone": contacts[0]["cellPhone"]!,"secondPhone": contacts[0]["secondPhone"]!]
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "UpdatePrimaryContact"), object: nil, userInfo: newPrimarycontact)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row >= contacts.count && self.isEditing {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        }
    }

}
