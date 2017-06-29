//
//  ChartVC.swift
//  RM53
//
//  Created by Ayu on 6/27/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
import PieCharts

class ChartVC: UIViewController, PieChartDelegate {
    
    @IBOutlet weak var totalRevenue: UILabel!
    @IBOutlet weak var chartView: PieChart!
    let PieSliceModelWithName: [String:PieSliceModel] = [String:PieSliceModel]()
    
    fileprivate static let alpha: CGFloat = 0.5
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
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.layers = [createPlainTextLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    // MARK: - Models
    
    fileprivate func createModels() -> [PieSliceModel] {
        
        let models = [
            PieSliceModel(value: 45.6e3, color: colors[0], name: "Deposit"),
            PieSliceModel(value: 55e3, color: colors[1], name: "TM"),
            PieSliceModel(value: 30e3, color: colors[2], name: "Credit"),
            PieSliceModel(value: 20e3, color: colors[3], name: "Cap Market"),
            PieSliceModel(value: 10e3, color: colors[4], name: "Non Commercial"),
        ]
        var total = 0.0
        for model in models {
            total += model.value
        }
        
        totalRevenue.text = "$\(total/1000)k"
        
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
    
//    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
//        let lineTextLayer = PieLineTextLayer()
//        var lineTextLayerSettings = PieLineTextLayerSettings()
//        lineTextLayerSettings.lineColor = UIColor.lightGray
//        let formatter = NumberFormatter()
//        formatter.maximumFractionDigits = 1
//        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
//        lineTextLayerSettings.label.textGenerator = {slice in
//            return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
//        }
//        
//        lineTextLayer.settings = lineTextLayerSettings
//        return lineTextLayer
//    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}

var AssociatedObjectHandle: UInt8 = 0

extension PieSliceModel {
    var name:String {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public convenience init(value: Double, color: UIColor, name: String?) {
                self.init(value: value, color: color)
                self.name = name!
            }
}


