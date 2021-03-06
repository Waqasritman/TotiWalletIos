//
//  CompleteRegistrationVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import AYPopupPickerView
class CompleteRegistrationVC: BaseVC , CountryListProtocol , IdTypeProtocol {
    
    let authRepository:AuthRepository = AuthRepository()
    let editCustomerRequest:EditCustomerProfileRequest = EditCustomerProfileRequest()
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var lblRegistrationType: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var lblIDType: UILabel!
    @IBOutlet weak var btnIDType: UIButton!
    @IBOutlet weak var lblIDNumber: UILabel!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var btnIssueDate: UIButton!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var btnExpireDate: UIButton!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var dobStackView: UIStackView!
    @IBOutlet weak var numberStack:UIStackView!
    
    @IBOutlet weak var lblCountryCode:UILabel!
    @IBOutlet weak var countryFlag:UIImageView!
    
    var isNumberEmpty = false
    let popupDatePickerView = AYPopupDatePickerView()
    
    var isIssueCountrySelect = false
    var isNumberCountrySelect = false
    var isIssueDateSelected = false
    var isExpireDateSelected = false
    
    var idType:String = ""
    var dateOfBirth:String = ""
    var countryCode:String = ""
    override func isValidate() -> Bool {
        if isNumberEmpty {
            if countryCode.isEmpty {
                return false
            } else if txtPhoneNumber.text!.isEmpty {
                return false
            } else if !verifyNumber(number: countryCode + txtPhoneNumber.text!) {
                showError(message: "Entered Number Is Invalid")
                return false
            }
            return false
        }
        if !isIssueCountrySelect {
            return false
        } else if idType.isEmpty {
            return false
        } else if txtNumber.text!.isEmpty {
            return false
        } else if !isIssueDateSelected {
            return false
        } else if !isExpireDateSelected {
            return false
        } else if !switchOutlet.isOn {
            if dateOfBirth.isEmpty {
                return false
            }
        }
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        setLabels()
        setLocalizie()
    }
    
    
    
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnSwitchFunc(_ sender: UISwitch) {
        setLabels()
    }
    
    
    @IBAction func btnIssueCountry(_ sender:Any) {
        isIssueCountrySelect = true
        isNumberCountrySelect = false
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnIdType(_ sender:Any) {
        if !idType.isEmpty {
            let nextVC = ControllerID.idTypesVC.instance
            (nextVC as! IDTypeVC).idType = idType
            (nextVC as! IDTypeVC).delegate = self
            self.pushWithFullScreen(nextVC)
        } else {
            self.showError(message: "Select issuance Country")
        }
    }
    
    
    
    
    @IBAction func btnIdIssueDate(_ sender:UIButton) {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.datePickerView.datePickerMode = .date
        popupDatePickerView.datePickerView.maximumDate = Date()
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            self.btnIssueDate.setTitle(self.getFormatedDate(date: date), for: .normal)
            self.btnIssueDate.setTitleColor(UIColor.black, for: .normal)
            self.editCustomerRequest.idIssueDate = self.getFormatedDate(date: date)
            self.isIssueDateSelected = true
        })
    }
    
    
    @IBAction func btnIdExpireDate(_ sender:UIButton) {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.datePickerView.datePickerMode = .date
        popupDatePickerView.datePickerView.minimumDate = Date()
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            self.btnExpireDate.setTitle(self.getFormatedDate(date: date), for: .normal)
            self.btnExpireDate.setTitleColor(UIColor.black, for: .normal)
            self.editCustomerRequest.idExpireDate = self.getFormatedDate(date: date)
            self.isExpireDateSelected = true
        })
    }
    
    
    @IBAction func btnDateOfBirthClick(_ sender:UIButton) {
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        
        components.year = -18
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        
        popupDatePickerView.datePickerView.minimumDate = minDate
        popupDatePickerView.datePickerView.maximumDate = maxDate
        
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            self.btnDOB.setTitle(self.getFormatedDate(date: date), for: .normal)
            self.btnDOB.setTitleColor(UIColor.black, for: .normal)
            self.dateOfBirth = self.getFormatedDate(date: date)
            self.editCustomerRequest.customer.dob = self.getFormatedDate(date: date)
        })
    }
    
    
    
    @IBAction func btnUpdateUser(_ sender:UIButton) {
        if isValidate() {
            editCustomerRequest.customer = preferenceHelper.getCustomerData()
            if isNumberEmpty {
                editCustomerRequest.customer.phoneNumber = ""
            } else {
                editCustomerRequest.customer.phoneNumber = preferenceHelper.getPhoneForKYC()
            }
            editCustomerRequest.customerNo = preferenceHelper.getCustomerNo()
            editCustomerRequest.languageId = preferenceHelper.getLanguage()
            editCustomerRequest.idNumber = txtNumber.text!
            editCustomerRequest.customer.dob = dateOfBirth
            print(editCustomerRequest.getXML())
            
            if Network.isConnectedToNetwork() {
                showProgress()
                authRepository.editCustomerProfile(request: HTTPConnection.openConnection(stringParams: editCustomerRequest.getXML(), action: SoapActionHelper.shared.ACTION_EDIT_PROFILE), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error  {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        let nextVC = ControllerID.cardKyc.instance
                        self.pushWithFullScreen(nextVC)
                    } else {
                        self.showError(message: response!.description!)
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
    
    
    func setLocalizie() {
        if preferenceHelper.getPhoneForKYC().isEmpty {
            numberStack.isHidden = false
            isNumberEmpty = true
        }
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        if isNumberCountrySelect {
            // lblCountry.text = country.countryName
            
        } else if isIssueCountrySelect {
            btnCountry.setTitle(country.countryName, for: .normal)
            btnCountry.setTitleColor(UIColor.black, for: .normal)
            idType = country.countryShortName
            editCustomerRequest.residenceCountry  = country.countryShortName
        }
    }
    
    
    func onSelectId(idType: IdType) {
        btnIDType.setTitle(idType.idTypeName, for: .normal)
        btnIDType.setTitleColor(.black, for: .normal)
        editCustomerRequest.idType = idType.id
    }
    
    
}
extension CompleteRegistrationVC {
    func initDesign() {
        popupDatePickerView.datePickerView.datePickerMode = .date
        txtPhoneNumber.setLeftPaddingPoints(10)
        txtNumber.setLeftPaddingPoints(10)
        
        btnCountry.layer.cornerRadius = 8
        btnIDType.layer.cornerRadius = 8
        txtNumber.layer.cornerRadius = 8
        btnIssueDate.layer.cornerRadius = 8
        btnExpireDate.layer.cornerRadius = 8
        btnDOB.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnIDType.imageEdgeInsets.left = self.view.frame.width - 50
        btnIssueDate.imageEdgeInsets.left = self.view.frame.width - 50
        btnExpireDate.imageEdgeInsets.left = self.view.frame.width - 50
        btnDOB.imageEdgeInsets.left = self.view.frame.width - 50
        countryFlag.makeImageCircle()
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
    }
    
    
    func setLabels() {
        if switchOutlet.isOn == false {
            editCustomerRequest.customer.dob = dateOfBirth
            lblRegistrationType.text = "Individual registration"
            lblCountry.text = "ID issuance country*"
           // btnCountry.setTitle("select Country", for: .normal)
            lblIDType.text = "ID type*"
          //  btnIDType.setTitle("Please select ID type", for: .normal)
            lblIDNumber.text = "ID Number*"
           // txtNumber.placeholder = "Enter number"
            lblIssueDate.text = "ID issue date*"
          //  btnIssueDate.setTitle("mm/dd/yyyy", for: .normal)
            lblExpireDate.text = "ID expire date*"
           // btnExpireDate.setTitle("mm/dd/yyyy", for: .normal)
            dobStackView.isHidden = false
            
        }
        else {
            editCustomerRequest.customer.dob = "10/12/1900"
            lblRegistrationType.text = "Business registration"
            lblCountry.text = "Business issuance country*"
          //  btnCountry.setTitle("select Country", for: .normal)
            lblIDType.text = "Business id type*"
           // btnIDType.setTitle("Please select ID type", for: .normal)
            lblIDNumber.text = "Business id number"
           // txtNumber.placeholder = "1234"
            lblIssueDate.text = "Business id issue date*"
          //  btnIssueDate.setTitle("mm/dd/yyyy", for: .normal)
            lblExpireDate.text = "Business id expire date*"
          //  btnExpireDate.setTitle("mm/dd/yyyy", for: .normal)
            dobStackView.isHidden = true
        
        }
    }
}
