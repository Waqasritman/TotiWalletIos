//
//  ForgotPassGetEmailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetEmailVC: BaseVC  , CountryListProtocol {
   
    

    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var viewCode: UIView!
    
    var isByNumber:Bool = false;
    
    override func isValidate() -> Bool {
        if isByNumber {
            if txtNumber.text!.isEmpty {
                return false
            }
        } else {
            if txtEmail.text!.isEmpty {
                showError(message: "Enter email address")
                return false
            } else if !String().isValidEmailAddress(emailAddressString: txtEmail.text!) {
                showError(message: "Enter correct email address")
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnContinue.layer.cornerRadius = 8
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
        
        if isByNumber {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        }
        else{
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
    }
    
    
    @IBAction func btnConfirm(_ sender:Any) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetCustomerProfileRequest()
                if isByNumber {
                    
                } else {
                    request.emailAddress = txtEmail.text!
                    request.mobileNo = ""
                }
                request.languageId = "1"
                
                authRepo.getCustomerProfile(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                     
                        if self.isByNumber {
                            ForgotPinRequestApprovedUserRequest.shared.mobileNumber = self.txtNumber.text!
                            ForgotPinRequestApprovedUserRequest.shared.emailAddress = ""
                            ForgotPinRequestApprovedUserRequest.shared.languageId = "1"
                        } else {
                            ForgotPinRequestApprovedUserRequest.shared.mobileNumber = ""
                            ForgotPinRequestApprovedUserRequest.shared.emailAddress = self.txtEmail.text!
                            ForgotPinRequestApprovedUserRequest.shared.languageId = "1"
                        }
                        
                        
                        if response!.isApprovedKYC {
                            // then get the id details
                            print(response!.firstName)
                            ForgotPinRequestApprovedUserRequest.shared.idNumber = response!.idNumber
                            ForgotPinRequestApprovedUserRequest.shared.idExpireDate = response!.idExpireDate
                            
                            let nextVc = ControllerID.forgotPassGetDataVC.instance
                            self.pushWithFullScreen(nextVc)
                        } else {
                            // then send to otp
                            print(response!.firstName)
                            ForgotPinRequestApprovedUserRequest.shared.idNumber = ""
                            ForgotPinRequestApprovedUserRequest.shared.idExpireDate = ""
                            let nextVc = ControllerID.forgotPassPinCV.instance
                            self.pushWithFullScreen(nextVc)
                        }
                    }
                })
                
                
            } else {
                self.noInternet()
            }
        }
    }

    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        
    }

}
