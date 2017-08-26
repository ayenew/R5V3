//
//  CustomTF.swift
//  RM53
//
//  Created by Ayu on 8/26/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//
import UIKit
@IBDesignable
class CustomTF: UITextField {
    @IBInspectable
    var leftPadding : Int = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var leftViewImage : UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var rightViewImage : UIImage? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftViewImage {
            self.leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 25, height: 25))
            imageView.image = image
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25 + leftPadding, height: 25))
            view.addSubview(imageView)
            self.leftView = view
            if placeholder != nil {
                attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: tintColor])
            }
        }
        if let image = rightViewImage {
            self.rightViewMode = .whileEditing
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20 + leftPadding, height: 20))
            view.addSubview(imageView)
            self.rightView = view
        }
    }
    
}
