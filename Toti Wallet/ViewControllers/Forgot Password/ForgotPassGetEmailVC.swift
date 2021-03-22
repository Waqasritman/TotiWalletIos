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
  
    @IBOutlet weak var lblCode: UILabel!
    
    @IBOutlet weak var btnFlag: UIImageView!
    @IBOutlet weak var pageSubTitle: UILabel!
    
    var isByNumber:Bool = false;
    var isCountrySelected = false
    override func isValidate() -> Bool {
        if isByNumber {
            if !isCountrySelected {
                self.showError(message:"plz_select_country_code".localized)
                return false
            } else if txtNumber.text!.isEmpty {
                self.showError(message: "enter_email_or_number_login".localized)
                return false
            } else if !verifyNumber(number: lblCode.text! + txtNumber.text!) {
                showError(message: "plz_enter_valid_phone_or_email".localized)
                return false
            }
        } else {
            if txtEmail.text!.isEmpty {
                showError(message: "pleaseenter_email_address".localized)
                return false
            } else if !String().isValidEmailAddress(emailAddressString: txtEmail.text!) {
                showError(message:"plz_enter_valid_phone_or_email".localized)
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFlag.makeImageCircle()
        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnContinue.layer.cornerRadius = 8
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
        txtEmail.setLeftPaddingPoints(5)
        txtNumber.setLeftPaddingPoints(5)
        
        if isByNumber {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
            pageSubTitle.text = "Please_enteR_nmber".localized
        } else{
            phoneNumberView.isHidden = true
            emailView.isHidden = false
            pageSubTitle.text = "Please_Enter_email_txt_phone".localized
        }
        
        txtNumber.placeholder = "phone_number_hint".localized
        btnContinue.setTitle("continue_txt".localized, for: .normal)
        txtEmail.placeholder = "enteremaail_adress".localized
    }
    
    
    @IBAction func btnConfirm(_ sender:Any) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetCustomerProfileRequest()
                if isByNumber {
                    request.emailAddress = ""
                    request.mobileNo = String().removePlus(number: lblCode.text! + txtNumber.text!)
                } else {
                    request.emailAddress = txtEmail.text!
                    request.mobileNo = ""
                }
                request.languageId = "1"
                
                authRepo.getCustomerProfile(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER), completion: { [self](response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                     
                        if self.isByNumber {
                            ForgotPinRequestApprovedUserRequest.shared.mobileNumber = String().removePlus(number: self.lblCode.text! + self.txtNumber.text!)
                            ForgotPinRequestApprovedUserRequest.shared.emailAddress = ""
                            ForgotPinRequestApprovedUserRequest.shared.languageId = preferenceHelper.getApiLangugae()
                        } else {
                            ForgotPinRequestApprovedUserRequest.shared.mobileNumber = ""
                            ForgotPinRequestApprovedUserRequest.shared.emailAddress = self.txtEmail.text!
                            ForgotPinRequestApprovedUserRequest.shared.languageId = preferenceHelper.getApiLangugae()
                        }
                        
                        
//                        if response!.isApprovedKYC {
//                            // then get the id details
//                            print(response!.firstName)
//                            ForgotPinRequestApprovedUserRequest.shared.idNumber = response!.idNumber
//                            ForgotPinRequestApprovedUserRequest.shared.idExpireDate = response!.idExpireDate
//
//                            let nextVc = ControllerID.forgotPassGetDataVC.instance
//                            (nextVc as! ForgotPassGetDataVC).isByNumber = self.isByNumber
//                            self.pushWithFullScreen(nextVc)
//                        } else {
                            // then send to otp
                            print(response!.firstName)
                            ForgotPinRequestApprovedUserRequest.shared.idNumber = ""
                            ForgotPinRequestApprovedUserRequest.shared.idExpireDate = ""
                            let nextVc = ControllerID.forgotPassotpVC.instance
                            (nextVc as! ForgotPassotpVC).isByNumber = self.isByNumber
                            self.pushWithFullScreen(nextVc)
                       // }
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
        lblCode.text = country.countryCode
        isCountrySelected = true
        btnFlag.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
    }

}
