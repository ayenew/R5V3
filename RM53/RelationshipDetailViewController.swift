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
        let contact = relationship["contact"] as! [[String:String]]
        let primaryContact = contact[0]
        let lastName = primaryContact["lastName"]!
        let firstName = primaryContact["firstName"]!
        let firstPhone = primaryContact["cellPhone"]
        let secondPhone = primaryContact["secondPhone"]
        self.primaryContact.text = "\(lastName),\(firstName)"
        self.companyPhone.text = firstPhone
        self.secondaryPhone.text = secondPhone
        self.address.text = (relationship["address"] as! String)
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
