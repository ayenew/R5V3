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
//    lazy var calendarViewController: CalendarVC = {
//        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "Calendar_SID")
//        rmCalendarView.addSubview(vc.view)
//        
//        
//        return vc
//    }()
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
        
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Calendar_SID") as! CalendarVC
        rmCalendarView.addSubview(vc.view)
        vc.view.frame = rmCalendarView.frame
        vc.didMove(toParentViewController: self)
         //   rmCalendarView.addSubview(vc.view)
//        let calendarVC = CalendarVC()
//        calendarVC.view.frame = rmCalendarView.frame
//        rmCalendarView.addSubview(calendarVC.view)
//        
//        self.addChildViewController(calendarVC)
//        self.view.addSubview(calendarVC.view)
//        calendarVC.didMove(toParentViewController: self)
 
//        let sb = UIStoryboard(name: "Calendar", bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: "CalendarVC") as! UINavigationController
//        //let navigationController = UINavigationController(rootViewController: controller)
//        controller.topViewController?.view.frame = self.rmCalendarView.frame
//        self.addChildViewController(controller)
//        rmCalendarView.addSubview((controller.topViewController?.view)!)
//        controller.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

