//
//  SignUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC , CountryListProtocol {
    
    func onSelectCountry(country: WRCountryList) {
        if lblCode != nil {
            lblCode.text = country.countryCode
            countryCode = country.countryCode
        }
    }
    
    let authRepository:AuthRepository = AuthRepository()
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var lblCode: UILabel!
    
    var countryCode:String = ""
    var isSignUpViaNumber = true
    
    
    override func isValidate() -> Bool {
        if isSignUpViaNumber {
            if countryCode.isEmpty {
                showError(message: "Select country")
                return false
            } else if txtPhoneNumber.text!.isEmpty {
                showError(message: "Enter phone number")
                return false
            } else if !verifyNumber(number: countryCode + txtPhoneNumber.text!) {
                showError(message: "Enter Number Is Invalid")
                return false
            }
        } else {
            if txtEmail.text!.isEmpty {
                showError(message: "Enter email address")
                return false
            } else if !String().isValidEmailAddress(emailAddressString: txtEmail.text!) {
                showError(message: "Invalid email address")
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
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
    }
    
    @objc
    func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        
        if isValidate() {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                let authRequest = AuthenticationRequest()
                if isSignUpViaNumber {
                    authRequest.email = ""
                    authRequest.languageID = "1"
                    authRequest.mobileNumber = String().removePlus(number: countryCode + txtPhoneNumber.text!)
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
