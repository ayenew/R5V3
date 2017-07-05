//
//  FirstViewController.swift
//  RM53
//
//  Created by Ayu on 6/27/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
import PieCharts

class FirstViewController: UIViewController {
    
    @IBOutlet weak var mainBar: UINavigationBar!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet var rmChart2: UIView!
    @IBOutlet weak var opportunityContainer: UIView!
    @IBOutlet var rmOpportunityView: UIView!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet var rmCalendarView: UIView!
    @IBOutlet var rmChartBookChart: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainBar.barTintColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        UIApplication.shared.statusBarStyle = .lightContent
        self.mainBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        view.addSubview(rmChartBookChart)
        view.addSubview(rmCalendarView)
        view.addSubview(rmOpportunityView)
        view.addSubview(rmChart2)
        
        rmChartBookChart.frame = CGRect(x: 4, y: 24, width: self.view.frame.width/3-12, height: self.view.frame.height-4)
        rmCalendarView.frame = CGRect(x: self.view.frame.width/3, y: 48, width: self.view.frame.width/3, height: self.view.frame.height/2-4)
        rmOpportunityView.frame = CGRect(x: self.view.frame.width/3, y: self.view.frame.height/2 + 48, width: 2 * self.view.frame.width/3-8, height: self.view.frame.height/2 - 47)
         rmChart2.frame = CGRect(x: 2 * self.view.frame.width/3, y: 45, width: self.view.frame.width/3-4, height: self.view.frame.height/2-2)
        
        let chartVC = ChartVC(nibName:"ChartVC",bundle: nil) 
        let chartView:ChartView = chartVC.view as! ChartView
        chartView.frame = rmChartBookChart.frame
        
        rmChartBookChart.addSubview(chartView)
        rmOpportunityView.addSubview(opportunityContainer)
        
        self.alertView.dropShadow()
        self.collectionView.dropShadow()
       // self.view.backgroundColor = UIColor.lightText
    }
}

