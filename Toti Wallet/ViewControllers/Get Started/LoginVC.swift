//
//  LoginVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    let authRepository:AuthRepository = AuthRepository()
    //MARK - variables
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var checkBoxOutlet:UIButton!{
        didSet{
            checkBoxOutlet.setImage(UIImage(named:"unchecked"), for: .normal)
            checkBoxOutlet.setImage(UIImage(named:"checked"), for: .selected)
        }
    }
    
    @IBOutlet weak var viewVerificationCode: KWVerificationCodeView!
    var isByPhoneNumber = false
    
    
    override func isValidate() -> Bool {
        
        if isByPhoneNumber {
            
        } else  {
            if txtEmail.text!.isEmpty {
                showError(message: "Enter email address")
                return false
            } else if getCode().count < 4 {
                showError(message: "Enter correct pin")
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewVerificationCode.textFieldViews.forEach({ (KWTextFieldView) in
            KWTextFieldView.clipsToBounds = true
            KWTextFieldView.layer.cornerRadius = 8
        })
        
        btnLogin.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        if isByPhoneNumber {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        }
        else{
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
    }
    
    
    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        let nextVC = ControllerID.selectCountryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func checkbox(_ sender: UIButton){
        sender.checkboxAnimation {
            print(sender.isSelected)
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if isValidate() {
            hideKeyboard()
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = LoginRequest()
                if isByPhoneNumber {
                    request.mobileNumber = txtPhoneNumber.text!
                    request.email = ""
                } else {
                    request.email = txtEmail.text!
                    request.mobileNumber = ""
                }
                request.password = getCode()
                
                authRepository.loginRequest(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_LOGIN),completion: { (response, error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response?.responseCode == 101 {
                        let nextVC = ControllerID.tabbar.instance
                        self.pushWithFullScreen(nextVC)
                    }
                })
            } else {
                self.noInternet()
            }
        }
        
        
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK - functions
    
    func getCode() -> String {
        return viewVerificationCode.getVerificationCode()
    }
    
}
