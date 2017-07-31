//
//  RelationshipDetailViewController.swift
//  RM53
//
//  Created by Ayu on 7/15/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class RelationshipDetailViewController: UIViewController {
    
    private lazy var overviewViewController: OverviewContainerVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Relationship", bundle: Bundle.main)
        
        // Instantiate View Controller
       // var viewController = storyboard.instantiateViewController(withIdentifier: "OverviewViewController") as! OverviewViewController
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "OverviewViewController") as! OverviewContainerVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var companyOpportunityViewController: CompanyOpportunityViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Relationship", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CompanyOpportunityViewController") as! CompanyOpportunityViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var productViewController: ProductViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Relationship", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    
    @IBOutlet weak var containerView: UIView!
    
    var name: String = ""
    @IBOutlet var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 33/255.0, green: 61/255.0, blue: 159/255.0, alpha: 1)
        self.navigationItem.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        setupView()
        updateView()
    }
    
    func setupView(){
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Company Overview", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Open Opportunities", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Product Information", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: productViewController)
            remove(asChildViewController: companyOpportunityViewController)
            add(asChildViewController: overviewViewController)
            updateOverviewOverview()
        } else if segmentedControl.selectedSegmentIndex == 1 {
            remove(asChildViewController: overviewViewController)
            remove(asChildViewController: productViewController)
            add(asChildViewController: companyOpportunityViewController)
            updateOverviewOverview()
        } else {
            remove(asChildViewController: overviewViewController)
            remove(asChildViewController: companyOpportunityViewController)
            add(asChildViewController: productViewController)
            updateOverviewOverview()
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

    func updateOverviewOverview(){
       // overviewViewController.name = self.name
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
