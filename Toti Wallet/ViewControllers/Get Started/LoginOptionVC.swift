//
//  LoginOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class LoginOptionVC: UIViewController {

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberView.layer.cornerRadius = 8
        emailView.layer.cornerRadius = 8
        
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(phoneViewFunc(_:)))
        phoneNumberView.addGestureRecognizer(phoneViewGesture)
        
        let emailViewGesture = UITapGestureRecognizer(target: self, action: #selector(emailViewFunc(_:)))
        emailView.addGestureRecognizer(emailViewGesture)
    }
    
    @objc private func phoneViewFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.loginVC.instance
        (nextVC as! LoginVC).isByPhoneNumber = true
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func emailViewFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.loginVC.instance
        (nextVC as! LoginVC).isByPhoneNumber = false
        self.pushWithFullScreen(nextVC)
    }

    @IBAction func btnSignUpFunc(_ sender: UIButton) {
        let nextVC = ControllerID.signUpVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
