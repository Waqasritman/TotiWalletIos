//
//  RequestMoneyVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class RequestMoneyVC: BaseVC  , CountryListProtocol , CurrencyListProtocol {
   
    
    let repo : Repository = Repository()
    let moneyRepo:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnRequestMoney: UIButton!
    @IBOutlet weak var codeLbl:UILabel!
    
    @IBOutlet weak var flagIcon: UIImageView!
    
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var toolTitlelbl: UILabel!
    @IBOutlet weak var pageTitlelbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    @IBOutlet weak var requestCurrencylbl: UILabel!
    @IBOutlet weak var requestCurrencyView: UIView!
    @IBOutlet weak var rquestCurrencyImage: UIImageView!
    @IBOutlet weak var requestCurrencyLBL: UILabel!
    
    let request = RequestMoney()
    override func isValidate() -> Bool {
        
        if codeLbl.text!.isEmpty {
            self.showError(message: "plz_select_country_code".localized)
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            self.showError(message: "enter_mobile_no_error".localized)
            return false
        }  else if !verifyNumber(number: codeLbl.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }  else if txtAmount.text!.isEmpty {
            self.showError(message: "please_enter_amount".localized)
            return false
        } else if request.requestCurrency.isEmpty {
            self.showError(message: "plz_select_requesting_cur".localized)
            return false
        }
        return true
    }
    
    
    
    func isNumberValidate() -> Bool {
        if codeLbl.text!.isEmpty {
            self.showError(message: "plz_select_country_code".localized)
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            self.showError(message: "enter_mobile_no_error".localized)
            return false
        } else if !verifyNumber(number: codeLbl.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCurrencyView.layer.cornerRadius = 8
        
        rquestCurrencyImage.makeImageCircle()
        requestCurrencylbl.text = "request_currency".localized
        toolTitlelbl.text = "wallet_transfer".localized
        pageTitlelbl.text = "request_money_from_wallet".localized
        mobileLbl.text = "mobile_number".localized
        amountlbl.text = "single_amount_txt".localized
        descriptionlbl.text = "description_txt_optional".localized
        btnRequestMoney.setTitle("request_money".localized, for: .normal)
        txtAmount.placeholder = "0.00".localized
        txtDescription.placeholder = "wallet_des_hint".localized
        txtPhoneNumber.placeholder = "phone_number_hint".localized
        
        txtAmount.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        txtAmount.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        flagIcon.makeImageCircle()
        btnRequestMoney.layer.cornerRadius = 8
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).codeShown = true
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    
    @IBAction func requestMoneyTouch(_ sender: Any) {
        if preferenceHelper.getISKYCApproved() {
            if isValidate() {
                if Network.isConnectedToNetwork() {
                    self.showProgress()
                    
                    request.amount = Double(txtAmount.text!)!
                    request.customerNo = preferenceHelper.getCustomerNo()
                    request.description = txtDescription.text!
                    request.mobileNo = String().removePlus(number: codeLbl.text!+txtPhoneNumber.text!)
                    moneyRepo.requestMoney(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_REQUEST_MONEY), completion: {(response , error) in
                        self.hideProgress()
                        if let error = error {
                            self.showError(message: error)
                        } else if response!.responseCode == 101 {
                            self.showAlert(title: "request_money".localized, message: "request_money_message".localized , hidebtn: true)
                        } else {
                            self.showError(message: response!.description!)
                        }
                    })
                }
            }
        }
        
        
    }
    
    @IBAction func btnRequest(_ sender:Any) {
        
    }
    
    
    
    @IBAction func btnRequestFunc(_ sender: UIButton) {
      
    }
    
    
    
    @IBAction func btnOnRequestCurrency(_ sender: Any) {
        if isNumberValidate() {
            getCustomerWallets()
        }
    }

    
    
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func getCustomerWallets() {
        if Network.isConnectedToNetwork() {
            let request = GetCCYForWalletRequest()
            request.customerNo = String().removePlus(number: codeLbl.text!+txtPhoneNumber.text!)
            request.actionType = CCYWalletActionType.RECEIVE
            request.languageID = preferenceHelper.getApiLangugae()
            self.showProgress()
            repo.getCCYWallets(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_ADD_CCY_WALLET), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showCurrency(list: response!.walletCurrencyList)
                } else if response!.description != nil {
                    self.showError(message: response!.description)
                } else {
                    self.showError(message: "something went wrong")
                }
            })
        }
    }
    
    
    
    func showCurrency(list:[RecCurrency]) {
        let nextVC = ControllerID.selectCurrencyVC.instance
        (nextVC as! SelectCurrencyVC).filteredList = list
        (nextVC as! SelectCurrencyVC).currencyProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        codeLbl.text = country.countryCode
        flagIcon.sd_setImage(with: URL(string: country.url))
    }
    
    
    func onSelectCurrency(currency: RecCurrency) {
        requestCurrencyLBL.text = currency.currencyShortName
        rquestCurrencyImage.sd_setImage(with: URL(string: currency.image_URL))
        request.requestCurrency = currency.currencyShortName
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
       
    }
    
}
