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
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet var rmCalendarView: UIView!
    @IBOutlet var rmChartBookChart: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rmChartBookChart)
        view.addSubview(rmCalendarView)
        rmChartBookChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/3, height: self.view.frame.height/2)
        rmCalendarView.frame = CGRect(x: self.view.frame.width/3, y: 0, width: self.view.frame.width/3, height: self.view.frame.height/2)
        let chartVC = ChartVC(nibName:"ChartVC",bundle: nil) 
        let chartView:ChartView = chartVC.view as! ChartView
        chartView.frame = rmChartBookChart.frame
        rmChartBookChart.addSubview(chartView)
        rmCalendarView.addSubview(calendarContainer)
    }
}

