//
//  OParentVC.swift
//  RM53
//
//  Created by Ayu on 8/24/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let switchBtn = UIBarButtonItem(image: UIImage(named: "swap"), style: .done, target: self, action: #selector(swap))
         switchBtn.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
        let logout = UIBarButtonItem(image: UIImage(named: "logout-2"), style: .done, target: self, action: #selector(logOut))
        logout.tintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
        self.navigationItem.rightBarButtonItems = [logout,switchBtn]
        
    }
    
    func swap() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func logOut(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.keyWindow?.rootViewController = login
    }

}
