//
//  RelationshipDetailViewController.swift
//  RM53
//
//  Created by Ayu on 7/15/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class RelationshipDetailViewController: UIViewController {
    @IBOutlet var addressView: UIView!
    @IBOutlet var chartView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var primaryContact: UILabel!
    
    @IBOutlet weak var secondaryPhone: UILabel!
    @IBOutlet weak var companyPhone: UILabel!
    @IBOutlet weak var smallBell: UIImageView!
    @IBOutlet weak var smallNotif: UIImageView!
    
    @IBOutlet weak var smallNotifValue: UILabel!
    @IBOutlet weak var smallBellValue: UILabel!
    @IBOutlet weak var address: UILabel!
    var relationship = [String:Any]()
    var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let chartVC = ChartVC(nibName:"ChartVC",bundle: nil)
        let chartView:ChartView = chartVC.view as! ChartView
        chartView.frame = addressView.frame
        chartView.dropShadow()
        navigationItem.title = (relationship["name"] as! String)
        primaryContact.tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
        let contact = relationship["contact"] as! [[String:String]]
        let mainContact = contact[0]
        let lastName = mainContact["lastName"]!
        let firstName = mainContact["firstName"]!
        let firstPhone = mainContact["cellPhone"]
        //let secondPhone = mainContact["secondPhone"]
        self.primaryContact.text = "\(lastName),\(firstName)"
        self.companyPhone.text = firstPhone
        //self.secondaryPhone.text = secondPhone
        self.address.text = (relationship["address"] as! String)
        let meeting = relationship["meeting"] as! Int
        let notification = relationship["notification"] as! Int
        if meeting  > 0 && notification > 0 {
            smallBell.tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
            smallBell.isHidden = false
            smallNotif.tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
            smallNotif.isHidden = false
            smallBellValue.text = "\(meeting) meeting(s)"
            smallNotifValue.text = "\(notification) notification(s)"
        } else if meeting > 0 && notification == 0 {
            smallBell.tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
            smallBell.isHidden = false
            smallBellValue.text = "\(meeting) meetings(s)"
            smallNotif.isHidden = true
            smallNotifValue.isHidden = true
        } else if meeting == 0 && notification > 0 {
            smallBell.image = UIImage(named: "smallbell")
            smallBell.isHidden = false
            smallBellValue.isHidden = false
            smallBellValue.text = "\(notification) notification(s)"
            smallBell.tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)
            smallNotif.isHidden = true
            smallNotifValue.isHidden = true
        } else {
            smallBell.isHidden = true
            smallNotif.isHidden = true
            smallNotifValue.isHidden = true
            smallBellValue.isHidden = true
        }

        NotificationCenter.default.addObserver(self, selector: #selector(updatePrimaryContact), name: NSNotification.Name.init(rawValue: "UpdatePrimaryContact"), object: nil)
        
    }
    
    func updatePrimaryContact(_ notification: NSNotification) {
        
        if let contact = notification.userInfo as? [String:String] {
            let firstName = contact["firstName"]!
            let lastName = contact["lastName"]!
            self.primaryContact.text = "\(String(describing: lastName)),\(String(describing: firstName))"
            self.companyPhone.text = contact["cellPhone"]!
            self.secondaryPhone.text = contact["secondPhone"]!
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chartVC" {
            let chartVC = segue.destination as! ProductViewController
            chartVC.productModel = relationship["product"] as! [String : Double]
        }
        if segue.identifier == "ProductVC" {
            let contactNavVC = segue.destination as! UINavigationController
            let contactVC = contactNavVC.topViewController as! OverViewTVC
            contactVC.contacts = relationship["contact"] as! [[String : String]]
        }
        if segue.identifier == "OpportunityVC" {
            let opportunityNavVC = segue.destination as! UINavigationController
            let opportunityVC = opportunityNavVC.topViewController as! CompanyOpportunityViewController
            opportunityVC.opportunities = relationship["opportunity"] as! [[String : String]]
        }
    }


}
