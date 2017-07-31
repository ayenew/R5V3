//
//  ProductViewController.swift
//  RM53
//
//  Created by Ayu on 7/29/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
import PieCharts

class ProductViewController: UIViewController , PieChartDelegate {

    @IBOutlet weak var chartView3: PieChart!
    @IBOutlet weak var chartView2: PieChart!
    @IBOutlet weak var chartView: PieChart!
    let PieSliceModelWithName: [String:PieSliceModel] = [String:PieSliceModel]()
    
    fileprivate static let alpha: CGFloat = 0.7
    let colors = [
        UIColor.yellow.withAlphaComponent(alpha),
        UIColor.green.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.blue.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 51/255.0, green: 74/255.0, blue: 157/255.0, alpha: 0.2)
        self.navigationItem.title = "Product Information"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.layers = [createPlainTextLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
        
        chartView2.layers = [createPlainTextLayer()]
        chartView2.delegate = self
        chartView2.models = createModels2()
        
        chartView.layers = [createPlainTextLayer()]
        chartView.delegate = self
        chartView.models = createModels()
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    // MARK: - Models
    
    
    fileprivate func createModels() -> [PieSliceModel] {
        let models = [
            PieSliceModel(value: 45.6e3, color: colors[4], name: "Deposit"),
            PieSliceModel(value: 55e3, color: colors[5], name: "TM"),
            PieSliceModel(value: 30e3, color: colors[6], name: "Credit"),
            PieSliceModel(value: 20e3, color: colors[7], name: "Cap Market"),
            PieSliceModel(value: 10e3, color: colors[8], name: "Non Commercial"),
            ]
        var total = 0.0
        for model in models {
            total += model.value
        }
        
        //totalRevenue.text = "$\(total/1000)k"
        
        currentColorIndex = models.count
        return models
    }
    
    fileprivate func createModels2() -> [PieSliceModel] {
        let models = [
            PieSliceModel(value: 20e2, color: colors[4], name: "Deposit"),
            PieSliceModel(value: 30e3, color: colors[5], name: "TM"),
            PieSliceModel(value: 40e3, color: colors[6], name: "Credit"),
            PieSliceModel(value: 50e3, color: colors[7], name: "Cap Market"),
            PieSliceModel(value: 60e3, color: colors[8], name: "Non Commercial"),
            ]
        var total = 0.0
        for model in models {
            total += model.value
        }
        
        //totalRevenue.text = "$\(total/1000)k"
        
        currentColorIndex = models.count
        return models
    }
    
    
    
        
    
    
    // MARK: - Layers
    
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.model.value/1000 as NSNumber).map{"\($0)K"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
