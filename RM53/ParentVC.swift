//
//  ParentVC.swift
//  RM53
//
//  Created by Ayu on 8/24/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {
    let tColor = UIColor.white
    override func viewDidLoad() {
        let logout = UIBarButtonItem(image: UIImage(named: "logout-2"), style: .done, target: self, action: #selector(logOut))
        logout.tintColor = tColor
        self.navigationItem.rightBarButtonItems = [logout]
        
    }
    
    func logOut(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.keyWindow?.rootViewController = login
    }
}
