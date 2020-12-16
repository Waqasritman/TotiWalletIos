//
//  CashBeneficaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficaryVC: BaseVC , CountryListProtocol , CurrencyListProtocol
                        , RelationProtocol {
 
    

 
    let authRepos:AuthRepository = AuthRepository()

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtlastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnRelation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var isCountrySelected = false
    var isRelationSelected = false
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        } else if txtMiddleName.text!.isEmpty {
            return false
        } else if txtlastName.text!.isEmpty {
            return false
        } else if txtMobile.text!.isEmpty {
            return false
        } else if !isCountrySelected {
            return false
        } else if txtAddress.text!.isEmpty {
            return false
        } else if !isRelationSelected {
            return false
        } else if txtName.text!.count < 3 {
            return false
        } else if txtMiddleName.text!.count < 2 {
            return false
        } else if txtlastName.text!.count < 3 {
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.layer.cornerRadius = 8
        txtMiddleName.layer.cornerRadius = 8
        txtlastName.layer.cornerRadius = 8
        txtMobile.layer.cornerRadius = 8
        btnCountry.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        btnRelation.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtMiddleName.setLeftPaddingPoints(10)
        txtlastName.setLeftPaddingPoints(10)
        txtMobile.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnRelation.imageEdgeInsets.left = self.view.frame.width - 50
        
        isCountrySelected = false
        isRelationSelected = false
        BeneficiaryAddRequest.shared.clearData()
    }

    @IBAction func btnNextFunc(_ sender: UIButton) {
        print(CountryTypeHelper.YEMEN)
        if isValidate() {
            BeneficiaryAddRequest.shared.FirstName = txtName.text!
            BeneficiaryAddRequest.shared.MiddleName = txtMiddleName.text!
            BeneficiaryAddRequest.shared.LastName = txtlastName.text!
            BeneficiaryAddRequest.shared.Telephone = txtMobile.text!
            BeneficiaryAddRequest.shared.Address = txtAddress.text!
            BeneficiaryAddRequest.shared.customerNo = preferenceHelper.getCustomerNo()
            BeneficiaryAddRequest.shared.languageId = preferenceHelper.getLanguage()
            if BeneficiaryAddRequest.shared.countryID == CountryTypeHelper.YEMEN {
                let nextVc = ControllerID.cashBeneficiaryBranchVC.instance
                self.pushWithFullScreen(nextVc)
            } else {
                let nextVc = ControllerID.cashBeneficaryAddressVC.instance
                self.pushWithFullScreen(nextVc)
            }
        }
       
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        self.gotoHome()
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnCountryTap(_ sender:UIButton) {
        let nextVc = ControllerID.selectCountryVC.instance
        (nextVc as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVc)
    }
    
    @IBAction func btnRelationTap(_ sender:UIButton) {
        let nextVc = ControllerID.relationVC.instance
        (nextVc as! RelationVC).delegate = self
        self.pushWithFullScreen(nextVc)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        isCountrySelected = true
        btnCountry.setTitle(country.countryName, for: .normal)
        BeneficiaryAddRequest.shared.PayoutCountryCode = country.countryShortName
        BeneficiaryAddRequest.shared.BankCountry = country.countryShortName
        BeneficiaryAddRequest.shared.countryID = country.countryId
        
        
        
        let recCurrencyRequest = GetSendRecCurrencyRequest()
        recCurrencyRequest.countryType = country.countryType
        recCurrencyRequest.countryShortName = country.countryShortName
        recCurrencyRequest.languageId = preferenceHelper.getLanguage()
        
        if Network.isConnectedToNetwork() {
            showProgress()
            self.authRepos.getReceiveCurrency(request: HTTPConnection.openConnection(stringParams: recCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_REC_CURRENCY), completion: {(response , error ) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.onCurrencyList(currencyList: response!.currencyList)
                } else {
                    self.hideProgress()
                    self.showError(message: response!.description)
                }
            })
        } else {
            self.noInternet()
        }
    }
    
    
    func onSelectRelation(relation: Relation) {
        isRelationSelected = true
        btnRelation.setTitle(relation.relationName, for: .normal)
        BeneficiaryAddRequest.shared.CustomerRelation = relation.relationName
        
    }
    
    func onSelectCurrency(currency: RecCurrency) {
        BeneficiaryAddRequest.shared.PayOutCurrency = currency.currencyShortName
        isCountrySelected = true
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        if currencyList.count == 1 {
            self.hideProgress()
            BeneficiaryAddRequest.shared.PayOutCurrency = currencyList[0].currencyShortName
            isCountrySelected = true
        } else {
            self.hideProgress()
            let nextVC = ControllerID.selectCurrencyVC.instance
            (nextVC as! SelectCurrencyVC).currencyProtocol = self
            (nextVC as! SelectCurrencyVC).filteredList = currencyList
            (nextVC as! SelectCurrencyVC).countriesList = currencyList
            self.pushWithFullScreen(nextVC)
        }
    }
    

}
