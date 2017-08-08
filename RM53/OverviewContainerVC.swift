//
//  OverviewContainerVC.swift
//  RM53
//
//  Created by Ayu on 7/30/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverviewContainerVC: UIViewController {

    @IBOutlet weak var chartView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.chartView)
        self.chartView.frame = CGRect(x: 0, y: self.view.frame.width/2, width: self.view.frame.width/2, height: self.view.frame.height/2)
        let chartVC = ChartVC(nibName:"ChartVC",bundle: nil)
        let chartContainer:ChartView = chartVC.view as! ChartView
        chartContainer.frame = self.chartView.frame
        chartContainer.dropShadow()
        
        self.chartView.addSubview(chartContainer)
    }
    
}
