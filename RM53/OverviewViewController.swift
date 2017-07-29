//
//  OverviewViewController.swift
//  RM53
//
//  Created by Ayu on 7/28/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    /// A simple data structure to populate the table view.
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    let sampleData1 = [
        PreviewDetail(title: "One", preferredHeight: 160.0),
        PreviewDetail(title: "Two", preferredHeight: 320.0),
        PreviewDetail(title: "Three", preferredHeight: 0.0), // 0.0 to get the default height.
        PreviewDetail(title: "More", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {
//            var frame = self.tableView.frame
//            frame.size.height = self.tableView.contentSize.height
//            self.tableView.frame = frame
//            
//            var frame1 = self.tableView1.frame
//            frame1.size.height = self.tableView1.contentSize.height
//            self.tableView1.frame = frame1
//        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        
        tableView.tableFooterView = UIView()
        tableView1.tableFooterView = UIView()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        
        var count:Int?
        
        if tableView == self.tableView {
            count = sampleData.count
        }
        
        if tableView == self.tableView1 {
            count =  sampleData1.count
        }
        
        return count!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.tableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let previewDetail = sampleData[indexPath.row]
            cell!.textLabel!.text = previewDetail.title
            
        }
        
        if tableView == self.tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let previewDetail = sampleData1[indexPath.row]
            cell!.textLabel!.text = previewDetail.title
            
        }
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select:      \(indexPath.row)  ")
    }
    
    
    
}
