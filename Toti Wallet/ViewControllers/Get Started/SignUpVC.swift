//
//  SignUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnAccept.layer.cornerRadius = 8
        btnSendOTP.layer.cornerRadius = 8
        
        btnSendOTP.layer.borderWidth = 1
        btnSendOTP.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        
    }
    
    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        //show countries here
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        let nextVC = ControllerID.verifyOptVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnSendOtpFunc(_ sender: UIButton) {
        if sender.titleLabel?.text == "Send OTP via e-mail" {
            btnSendOTP.setTitle("Send OTP via Mobile number", for: .normal)
            lblHeading.text = "Enter Your e-mail address"
            viewPhoneNumber.isHidden = true
            viewEmail.isHidden = false
        }
        else{
            btnSendOTP.setTitle("Send OTP via e-mail", for: .normal)
            lblHeading.text = "Enter Your mobile number"
            viewPhoneNumber.isHidden = false
            viewEmail.isHidden = true
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
