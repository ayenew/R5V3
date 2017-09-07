//
//  OParentVC.swift
//  RM53
//
//  Created by Ayu on 8/24/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class OParentVC: UIViewController {
    let tColor = UIColor.white
    override func viewDidLoad() {
        super.viewDidLoad()
        let switchBtn = UIBarButtonItem(image: UIImage(named: "swap"), style: .done, target: self, action: #selector(swap))
        switchBtn.tintColor = tColor
        let logout = UIBarButtonItem(image: UIImage(named: "logout-2"), style: .done, target: self, action: #selector(logOut))
        logout.tintColor = tColor
        self.navigationItem.rightBarButtonItems = [logout,switchBtn]
        
    }
    
    func swap() {
        let window = UIApplication.shared.keyWindow
        let rootVC = window?.rootViewController
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
        let alertController = UIAlertController(title: "Switch Mode", message: "Switch to full mode?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            DispatchQueue.main.async {
                vc.view.frame = (rootVC?.view.bounds)!
                vc.selectedIndex = 1
                window?.rootViewController = vc
            }
            UIView.transition(with: window!, duration: 0.4, options: .transitionFlipFromLeft, animations: {
                // window?.rootViewController = vc
            }) { (success) in
                //
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func logOut(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.keyWindow?.rootViewController = login
    }

}
