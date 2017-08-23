//
//  LoginVC.swift
//  RM53
//
//  Created by Ayu on 8/22/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    let user = "rm001"
    let pass = "rm001"
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var password: UITextField!
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
        userName.text = user
        password.text = pass
        if userName.text == user && password.text == pass {
            let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityView.center = self.view.center
            activityView.hidesWhenStopped = false
            activityView.startAnimating()
            //sleep(10)
            activityView.stopAnimating()
            self.view.addSubview(activityView)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let dashboard = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
            UIApplication.shared.keyWindow?.rootViewController = dashboard
        } else {
            print("error")
        }

    }
}
