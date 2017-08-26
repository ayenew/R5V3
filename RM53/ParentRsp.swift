//
//  ParentRsp.swift
//  RM53
//
//  Created by Ayu on 8/25/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ParentRsp: UIViewController {
    var selectedCompanyName = String()
    override func viewDidLoad() {
        let switchBtn = UIBarButtonItem(image: UIImage(named: "swap"), style: .done, target: self, action: #selector(swap))
         switchBtn.tintColor = UIColor.white
        let logout = UIBarButtonItem(image: UIImage(named: "logout-2"), style: .done, target: self, action: #selector(logOut))
        logout.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [logout, switchBtn]
        
    }
    
    func swap() {
        let window = UIApplication.shared.keyWindow
        let rootVC = window?.rootViewController
        let sb = UIStoryboard(name: "Other", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Other") as! UITabBarController
        vc.view.frame = (rootVC?.view.bounds)!
        vc.selectedIndex = 0
        let vcs = vc.viewControllers
        let nav = vcs?[0] as! UINavigationController
        let selectedVC = nav.topViewController as! ODashboardVC
        selectedVC.pageTitle = selectedCompanyName
        window?.rootViewController = vc
        UIView.transition(with: window!, duration: 0.4, options: .transitionFlipFromLeft, animations: {
           // window?.rootViewController = vc
        }) { (success) in
            //
        }
    }
    
    func logOut(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.keyWindow?.rootViewController = login
    }
}
