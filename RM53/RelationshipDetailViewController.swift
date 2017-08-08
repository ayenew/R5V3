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
    
    var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let chartVC = ChartVC(nibName:"ChartVC",bundle: nil)
        let chartView:ChartView = chartVC.view as! ChartView
        chartView.frame = addressView.frame
        chartView.dropShadow()
        navigationItem.title = name
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }


}
