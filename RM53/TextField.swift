//
//  TextField.swift
//  RM53
//
//  Created by Ayu on 8/23/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {

    @IBInspectable
    var leftImage: UIImage?  {
        didSet {
            update()
        }
    }
    
    func update(){
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let im = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        v.addSubview(im)
        self.leftView = v
    }
   
}
