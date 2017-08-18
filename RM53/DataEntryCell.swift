//
//  DataEntryCell.swift
//  RM53
//
//  Created by Ayu on 8/16/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

protocol DataTransferDelegate {
    //func passData(salesTarget: String, balance: String, targetDate: String)
    func passData()
    func cancelChange()
}

protocol DatePickerUpdateDelegate {
    func updateDatePicker(newDate: String)
}

class DataEntryCell: UITableViewCell {
    @IBOutlet weak var SalesStagePicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var targetDate: UILabel!
    @IBOutlet weak var balance: UITextField!
    @IBOutlet weak var salesTarget: UILabel!
    var dataTransferDelegate : DataTransferDelegate?
    var datePickerUpdateDelegate: DatePickerUpdateDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let date = DateFormatter.localizedString(from: sender.date, dateStyle: .short, timeStyle: .none)
        if let delegate = self.datePickerUpdateDelegate {
            delegate.updateDatePicker(newDate: date)
        }
       
    }
    
    @IBAction func save(_ sender: UIButton) {
       dataTransferDelegate?.passData()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dataTransferDelegate?.cancelChange()
    }
}
