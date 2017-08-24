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
    let user = "rm53"
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
        userName.text = user
        password.text = pass
        if userName.text == user && password.text == pass {
            activity.alpha = 1
            activity.activityIndicatorViewStyle = .gray
            activity.hidesWhenStopped = true
            activity.startAnimating()
            sleep(1)
            activity.stopAnimating()
            activity.alpha = 0
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let dashboard = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
            UIApplication.shared.keyWindow?.rootViewController = dashboard
        } else {
            print("error")
        }

    }
}
