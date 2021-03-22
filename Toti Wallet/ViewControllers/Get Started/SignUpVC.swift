//
//  SignUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC , CountryListProtocol {
    
    
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
    @IBOutlet weak var btnFlag: UIImageView!
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var ageRestrictLbl: UILabel!
    @IBOutlet weak var orLAbel: UILabel!
    

    var countryCode:String = ""
    var isSignUpViaNumber = true
    
    
    override func isValidate() -> Bool {
        if isSignUpViaNumber {
            if countryCode.isEmpty {
                showError(message: "plz_select_country_code".localized)
                return false
            } else if txtPhoneNumber.text!.isEmpty {
                showError(message: "enter_mobile_no_error".localized)
                return false
            } else if !verifyNumber(number: countryCode + txtPhoneNumber.text!) {
                showError(message: "invalid_number".localized)
                return false
            }
        } else {
            if txtEmail.text!.isEmpty {
                showError(message: "enter_email_or_number_login".localized)
                return false
            } else if !String().isValidEmailAddress(emailAddressString: txtEmail.text!) {
                showError(message: "plz_enter_valid_phone_or_email".localized)
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFlag.makeImageCircle()
        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnAccept.layer.cornerRadius = 8
        btnSendOTP.layer.cornerRadius = 8
        
        btnSendOTP.layer.borderWidth = 1
        btnSendOTP.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        setLabels()
    }
    
    @objc
    func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        (nextVC as! SelectCountryVC).codeShown = true
        self.pushWithFullScreen(nextVC)
    }
    
    
    func setLabels() {
        if isSignUpViaNumber {
            txtPhoneNumber.placeholder = "phone_number_hint".localized
            pageTitle.text = "enter_mobile_no_txt".localized
            btnSendOTP.setTitle("send_otp_email".localized, for: .normal)
        } else {
            txtEmail.placeholder = "email".localized
            pageTitle.text = "Please_Enter_email_txt".localized
            btnSendOTP.setTitle("send_otp_mobile".localized, for: .normal)
        }
        ageRestrictLbl.text = "submitting_txt".localized
        orLAbel.text = "or".localized
        btnAccept.setTitle("accept_continue".localized, for: .normal)
    }
    
    
    @IBAction func btnAccept(_ sender: UIButton) {
        
        if isValidate() {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                let authRequest = AuthenticationRequest()
                if isSignUpViaNumber {
                    authRequest.email = ""
                    authRequest.languageID = preferenceHelper.getApiLangugae()
                    authRequest.mobileNumber = String().removePlus(number: countryCode + txtPhoneNumber.text!)
                } else {
                    authRequest.email = txtEmail.text!
                    authRequest.languageID = preferenceHelper.getApiLangugae()
                    authRequest.mobileNumber = ""
                }
                
                print(authRequest.getXML())
                authRepository.authRequest(request: HTTPConnection.openConnection(stringParams: authRequest.getXML(), action: SoapActionHelper.shared.ACTION_AUTHENTICATION),completion: { (response, error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response?.responseCode == 101 {
                        
                        RegisterUserRequest.shared.email = authRequest.email
                        RegisterUserRequest.shared.phoneNumber = authRequest.mobileNumber
                        
                        let nextVC = ControllerID.verifyOptVC.instance
                        (nextVC as! VerifyOptVC).isByNumber = self.isSignUpViaNumber
                        (nextVC as! VerifyOptVC).authRequest = authRequest
                        self.pushWithFullScreen(nextVC)
                    }
                })
            } else {
                self.noInternet()
            }
        }
        
    }
    
    
    @IBAction func btnSendOtpFunc(_ sender: UIButton) {
        if sender.titleLabel?.text == "send_otp_email".localized {
        
            viewPhoneNumber.isHidden = true
            viewEmail.isHidden = false
            isSignUpViaNumber = false
            setLabels()
        }
        else{
           
            viewPhoneNumber.isHidden = false
            viewEmail.isHidden = true
            isSignUpViaNumber = true
            setLabels()
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func onSelectCountry(country: WRCountryList) {
        if lblCode != nil {
            lblCode.text = country.countryCode
            countryCode = country.countryCode
            btnFlag.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
        }
    }
    
}
