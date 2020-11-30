//
//  SignUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC {
    let authRepository:AuthRepository = AuthRepository()
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    
    var isSignUpViaNumber = true
    
    
    override func isValidate() -> Bool {
        if isSignUpViaNumber {
            if txtPhoneNumber.text!.isEmpty {
                showError(message: "Enter phone number")
            }
        } else {
            if txtEmail.text!.isEmpty {
                showError(message: "Enter email address")
                return false
            }
        }
        return true
    }
    
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
        
        if isValidate() {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                let authRequest = AuthenticationRequest()
                if isSignUpViaNumber {
                    authRequest.email = ""
                    authRequest.languageID = "1"
                    authRequest.mobileNumber = txtPhoneNumber.text!
                } else {
                    authRequest.email = txtEmail.text!
                    authRequest.languageID = "1"
                    authRequest.mobileNumber = ""
                }
                
                
                authRepository.authRequest(request: HTTPConnection.openConnection(stringParams: authRequest.getXML(), action: SoapActionHelper.shared.ACTION_AUTHENTICATION),completion: { (response, error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response?.responseCode == 101 {
                        
                        RegisterUserRequest.shared.email = authRequest.email
                        RegisterUserRequest.shared.phoneNumber = authRequest.mobileNumber
                        
                        let nextVC = ControllerID.verifyOptVC.instance
                        (nextVC as! VerifyOptVC).isByNumber = self.isSignUpViaNumber
                        self.pushWithFullScreen(nextVC)
                    }
                })
            } else {
                self.noInternet()
            }
            
            
            
            
        }
        
    }
    
    
    @IBAction func btnSendOtpFunc(_ sender: UIButton) {
        if sender.titleLabel?.text == "Send OTP via e-mail" {
            btnSendOTP.setTitle("Send OTP via Mobile number", for: .normal)
            lblHeading.text = "Enter Your e-mail address"
            viewPhoneNumber.isHidden = true
            viewEmail.isHidden = false
            isSignUpViaNumber = false
        }
        else{
            btnSendOTP.setTitle("Send OTP via e-mail", for: .normal)
            lblHeading.text = "Enter Your mobile number"
            viewPhoneNumber.isHidden = false
            viewEmail.isHidden = true
            isSignUpViaNumber = true
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
