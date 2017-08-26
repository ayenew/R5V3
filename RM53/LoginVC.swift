//
//  LoginVC.swift
//  RM53
//
//  Created by Ayu on 8/22/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    let user = "RM53"
    let pass = "rm53"
    @IBOutlet weak var userName: TextField!

    @IBOutlet weak var password: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKB))
        self.view.addGestureRecognizer(tap)
        self.userName.delegate = self
        self.password.delegate = self
    }

    @IBAction func login(_ sender: UIButton) {
        loadDashboard()
    }
    
    func dismissKB(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadDashboard()
        return true
    }
    
    func loadDashboard(){
        if userName.text?.lowercased() == user.lowercased() && password.text == pass {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let dashboard = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
            UIApplication.shared.keyWindow?.rootViewController = dashboard
        } else {
            let alertController = UIAlertController(title: "Login Failed", message: "Either the user name or password is wrong. Please try again.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                  self.userName.becomeFirstResponder()
                }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        }

    }
}
