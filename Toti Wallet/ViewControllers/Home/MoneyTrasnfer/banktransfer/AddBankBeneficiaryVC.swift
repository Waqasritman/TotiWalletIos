//
//  AddBankBeneficiaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddBankBeneficiaryVC: BaseVC , CountryListProtocol , RelationProtocol , CurrencyListProtocol
 , UITextFieldDelegate{
    
    let authRepos:AuthRepository = AuthRepository()
    var isCountrySelected = false
    var isRelationSelected = false
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var firstnamelbl: UILabel!
    @IBOutlet weak var lastNamelbl: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var relationlbl: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnRelation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            showError(message: "enter_name_bene__first_name_error".localized)
            return false
        }  else if txtLastName.text!.isEmpty {
            showError(message: "enter_name_bene__last_name_error".localized)
            return false
        } else if !isCountrySelected {
            showError(message: "plz_select_country_error".localized)
            return false
        }  else if !isRelationSelected {
            showError(message: "plz_select_relation".localized)
            return false
        }
//        else if txtName.text!.count < 3 {
//            showError(message: "".localized)
//            return false
//        }  else if txtLastName.text!.count < 3 {
//            showError(message: "".localized)
//            return false
//        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self
        txtLastName.delegate = self
        
        toolTitle.text = "bank_beneficairy".localized
        pageTitle.text = "send_money_via_bank".localized
        firstnamelbl.text = "first_name".localized
        lastNamelbl.text = "last_name_text_m".localized
        countrylbl.text = "select_country_m".localized
        relationlbl.text = "relation_with_beneficiary".localized
        
        txtName.placeholder = "john_txt".localized
        txtLastName.placeholder  = "smith" .localized
        btnCountry.setTitle("select_country".localized, for: .normal)
        btnRelation.setTitle("select_the_relation_txt".localized, for: .normal)

        btnNext.setTitle("next".localized, for: .normal)
        
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
            
            if BeneficiaryAddRequest.shared.countryID == 2 {
                let nextVc = ControllerID.indiaBankBeneVC.instance
                self.pushWithFullScreen(nextVc)
            } else if BeneficiaryAddRequest.shared.countryRegion == 1 {
                self.showError(message: "Sepa country")
            }
            else {
                let nextVc = ControllerID.addBankBeneficiaryBankDetail.instance
                self.pushWithFullScreen(nextVc)
            }
 
            
        }
    }

    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        isCountrySelected = true
        btnCountry.setTitle(country.countryName, for: .normal)
        btnCountry.setTitleColor(.black, for: .normal)
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
        btnRelation.setTitleColor(.black, for: .normal)
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
extension AddBankBeneficiaryVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
