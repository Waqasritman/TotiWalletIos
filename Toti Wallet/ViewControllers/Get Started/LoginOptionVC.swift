//
//  LoginOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class LoginOptionVC: BaseVC {

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var notAnExistinlbl: UIButton!
    
    @IBOutlet weak var usingMobilelbl: UILabel!
    @IBOutlet weak var usingEmaillbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberView.layer.cornerRadius = 8
        emailView.layer.cornerRadius = 8
        
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(phoneViewFunc(_:)))
        phoneNumberView.addGestureRecognizer(phoneViewGesture)
        
        let emailViewGesture = UITapGestureRecognizer(target: self, action: #selector(emailViewFunc(_:)))
        emailView.addGestureRecognizer(emailViewGesture)
        pageTitle.text  = "how_would_you_like_to_login".localized
        
        usingEmaillbl.text = "using_email_address".localized
        usingMobilelbl.text = "using_mobile".localized
        let string:String = "already_have_an_account".localized + " " + "sign_up".localized
      notAnExistinlbl.setTitle(string, for: .normal)
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
