//
//  AddBankBeneficiaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddBankBeneficiaryVC: BaseVC , CountryListProtocol , RelationProtocol , CurrencyListProtocol {
    
    let authRepos:AuthRepository = AuthRepository()
    var isCountrySelected = false
    var isRelationSelected = false
    

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnRelation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        }  else if txtLastName.text!.isEmpty {
            return false
        } else if !isCountrySelected {
            return false
        }  else if !isRelationSelected {
            return false
        } else if txtName.text!.count < 3 {
            return false
        }  else if txtLastName.text!.count < 3 {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.layer.cornerRadius = 8
        txtLastName.layer.cornerRadius = 8
        btnCountry.layer.cornerRadius = 8
        btnRelation.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtLastName.setLeftPaddingPoints(10)
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnRelation.imageEdgeInsets.left = self.view.frame.width - 50
       
    }
    
    
    
    @IBAction func btnCountryClick(_ sender:UIButton) {
        let nextVc = ControllerID.selectCountryVC.instance
        (nextVc as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVc)
    }
    
    @IBAction func btnRelationClick(_ sender:UIButton) {
        let nextVc = ControllerID.relationVC.instance
        (nextVc as! RelationVC).delegate = self
        self.pushWithFullScreen(nextVc)
    }   
    
    @IBAction func btnNextFunc(_ sender:UIButton) {
        if isValidate() {
            BeneficiaryAddRequest.shared.FirstName = txtName.text!
            BeneficiaryAddRequest.shared.MiddleName = ""
            BeneficiaryAddRequest.shared.LastName = txtLastName.text!
            let nextVc = ControllerID.addBankBeneficiaryBankDetail.instance
            self.pushWithFullScreen(nextVc)
        }
    }

    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        isCountrySelected = true
        btnCountry.setTitle(country.countryName, for: .normal)
        BeneficiaryAddRequest.shared.PayoutCountryCode = country.countryShortName
        BeneficiaryAddRequest.shared.BankCountry = country.countryShortName
        BeneficiaryAddRequest.shared.countryID = country.countryId
        BeneficiaryAddRequest.shared.countryRegion = country.countryOrigin
        
        
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
