//
//  LoginVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SDWebImage


class LoginVC: BaseVC {
    let restRepo:RestRepositor = RestRepositor()
    let authRepository:AuthRepository = AuthRepository()
    //MARK - variables
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewCode: UIView!
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var btnFlag:UIImageView!
    
    
    var countryCode:String = ""
    var flagURL:String = ""
    
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
            if countryCode.isEmpty {
                showError(message:  "selecet country")
                return false
            } else if txtPhoneNumber.text!.isEmpty {
                showError(message: "Enter Number")
                return false
            } else if !verifyNumber(number: countryCode + txtPhoneNumber.text!) {
                showError(message: "Enter Number Is Invalid")
                return false
            } else if getCode().count < 4 {
                showError(message: "Enter correct pin")
                return false
            }
        } else  {
            if txtEmail.text!.isEmpty {
                showError(message: "Enter email address")
                return false
            } else if getCode().count < 4 {
                showError(message: "enter_pin".localized)
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
        btnFlag.makeImageCircle()
        btnLogin.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
        if isByPhoneNumber {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        }
        else{
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if isByPhoneNumber {
            txtPhoneNumber.text = preferenceHelper.getNumber()
            lblCode.text = preferenceHelper.getCountryCode()
        } else if !preferenceHelper.getEmail().isEmpty{
            txtEmail.text = preferenceHelper.getEmail()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnForgotPin(_ sender:Any) {
        let nextVC = ControllerID.forgotPassGetEmailVC.instance
        (nextVC as! ForgotPassGetEmailVC).isByNumber = isByPhoneNumber
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func checkbox(_ sender: UIButton){
        sender.checkboxAnimation {
            print(sender.isSelected)
        }
        if !sender.isSelected {
            saveUserDetails()
        } else  {
            preferenceHelper.removeLoginDetails()
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if isValidate() {
            hideKeyboard()
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = LoginRequest()
                if isByPhoneNumber {
                    request.mobileNumber =  String().removePlus(number: countryCode +  txtPhoneNumber.text!)
                    request.email = ""
                } else {
                    request.email = txtEmail.text!
                    request.mobileNumber = ""
                }
                request.password = getCode()
                
                authRepository.loginRequest(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_LOGIN),completion: { (response, error) in
                    
                    if let error = error {
                        self.hideProgress()
                        self.showError(message: error)
                    } else if response?.responseCode == 101 {
                        self.getCustomerProfile(customerNo: response!.CustomerNumber!)
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
    
    
    func getCustomerProfile(customerNo:String) {
        if Network.isConnectedToNetwork() {
            let request = GetCustomerProfileRequest()
            request.customerNo = customerNo
            request.emailAddress = ""
            request.mobileNo = ""
            request.languageId = "1"
            
            
            authRepository.getCustomerProfile(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER), completion: {(response , error) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else {
                    if response!.responseCode == 101 {
                        
                        preferenceHelper.isWalletNeedToUpdate(isNeed: true);
                        preferenceHelper.setDocumentUploaded(value: response!.isDocUploaded)
                        preferenceHelper.setCustomerNo(customerNo: customerNo)
                        preferenceHelper.filCustomerData(userRequest: response!)
                        self.getCustomerImage(customerNo: customerNo)
                        
                    }
                }
            })
            
            
        } else {
            self.noInternet()
        }
    }
    
    
    
    
    func getCustomerImage(customerNo:String) {
        let request = GetCustomerProfileImageRequest()
        request.Customer_No = customerNo
        // request.credentials.LanguageID = 1
        print(request.toJSON())
        restRepo.getCustomerImage(param: request.toJSON(), completion: {(response ,error) in
            self.hideProgress()
            if let error = error {
                print(error)
                self.toHome()
            } else if response!.ResponseCode == 101 {
                print(response!.Description)
                preferenceHelper.userImage(imageData: response!.ImageData)
                self.toHome()
            } else {
                print(response!.Description)
                self.toHome()
            }
        })
    }
    
    
    
    func toHome() {
        let nextVC = ControllerID.tabbar.instance
        self.pushWithFullScreen(nextVC)
    }
    
}
extension LoginVC : CountryListProtocol {
    
    func onSelectCountry(country: WRCountryList) {
      
        lblCode.text = country.countryCode
        countryCode = country.countryCode
        
        flagURL = country.url
        btnFlag.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
     
    }
    
    
    func saveUserDetails() {
        if isByPhoneNumber {
            preferenceHelper.setCountryCode(code: countryCode)
            preferenceHelper.setNumber(number: txtPhoneNumber.text!)
            preferenceHelper.setURL(url: flagURL)
        } else {
            preferenceHelper.setEmail(txtEmail.text!)
        }
    }
}
