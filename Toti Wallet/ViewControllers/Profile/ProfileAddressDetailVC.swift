//
//  ProfileAddressDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ProfileAddressDetailVC: BaseVC , CountryListProtocol {
    
    
    let authRepositry:AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnCountryName: UIButton!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnNationality: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var countryName:String = ""
    var nationality:String = ""
    
    var isCountrySeleted = false
    
    override func isValidate() -> Bool {
        if countryName.isEmpty {
            return false
        } else if txtCity.text!.isEmpty {
            return false
        } else if txtAddress.text!.isEmpty {
            return false
        } else if nationality.isEmpty {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnCountryName.layer.cornerRadius = 8
        txtCity.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtCity.setLeftPaddingPoints(5)
        txtAddress.setLeftPaddingPoints(5)
        
        btnCountryName.imageEdgeInsets.left = self.view.frame.width - 50
        btnNationality.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        //show countries here
        isCountrySeleted = true
        showCountriesDialog()
    }
    
    @IBAction func btnNationalityFunc(_ sender: Any) {
        isCountrySeleted = false
        showCountriesDialog()
    }
    
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        if isValidate() {
            RegisterUserRequest.shared.city = txtCity.text!
            RegisterUserRequest.shared.address = txtAddress.text!
            print(RegisterUserRequest.shared.getXML())
            showProgress()
            authRepositry.registerUser(request: HTTPConnection.openConnection(stringParams: RegisterUserRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_CUSTOMER_REGISTRATION), completion: {(response , error) in
               
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else  {
                    if response?.responseCode == 101 {
                        
                    //    self.showSuccess(message: (response?.description)!)
                        self.getCustomerProfile(customerNo: (response?.CustomerNumber)!)
                    } else {
                        self.hideProgress()
                        self.showError(message: (response?.description)!)
                    }
                }
            })
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCustomerProfile(customerNo:String) {
        if Network.isConnectedToNetwork() {
            let request = GetCustomerProfileRequest()
            request.customerNo = customerNo
            request.emailAddress = ""
            request.mobileNo = ""
            request.languageId = "1"
            
            
            authRepositry.getCustomerProfile(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER), completion: {(response , error) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else {
                    if response!.responseCode == 101 {
                        self.hideProgress()
                        self.preferenceHelper.isWalletNeedToUpdate(isNeed: true);
                        self.preferenceHelper.setCustomerNo(customerNo: customerNo)
                        self.preferenceHelper.filCustomerData(userRequest: response!)
                        self.toHome()
                    }
                }
            })
            
            
        } else {
            self.noInternet()
        }
    }
    
    
    func toHome() {
        let nextVC = ControllerID.tabbar.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    func showCountriesDialog() {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        (nextVC as! SelectCountryVC).codeShown = false
        self.pushWithFullScreen(nextVC)
    }
    
    func onSelectCountry(country: WRCountryList) {
        if isCountrySeleted {
            btnCountryName.setTitle(country.countryName, for: .normal)
            countryName = country.countryShortName
            RegisterUserRequest.shared.country = "GBR"
        } else {
            btnNationality.setTitle(country.countryName, for: .normal)
            RegisterUserRequest.shared.nationality = country.countryShortName
            nationality = country.countryShortName
        }
    }
    
}
