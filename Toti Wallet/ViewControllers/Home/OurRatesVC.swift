//
//  OurRatesVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class OurRatesVC: BaseVC , CountryListProtocol , CurrencyListProtocol {
 
    var isSendingSelect = false
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnTransferNow: UIButton!
    @IBOutlet weak var firstDropDown: UIButton!
    @IBOutlet weak var secondDropDown: UIButton!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    
    
    
    override func isValidate() -> Bool {
        if txtFirst.text!.isEmpty {
            self.showError(message: "Enter sending amount")
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnTransferNow.layer.cornerRadius = 8
        
        firstDropDown.layer.cornerRadius = 8
        secondDropDown.layer.cornerRadius = 8
        txtFirst.layer.cornerRadius = 8
        txtSecond.layer.cornerRadius = 8
        
        firstDropDown.imageEdgeInsets.left = self.firstDropDown.frame.width - 15
        secondDropDown.imageEdgeInsets.left = self.secondDropDown.frame.width - 15
        
        txtFirst.setLeftPaddingPoints(10)
        txtSecond.setLeftPaddingPoints(10)
        
    }
    
    @IBAction func btnSendingCurrency(_ sender:Any) {
        isSendingSelect = true
        if Network.isConnectedToNetwork() {
            let walletCurrencyRequest = GetWalletCurrencyListRequest()
            walletCurrencyRequest.languageId = preferenceHelper.getLanguage()
            showProgress()
            moneyTransferRepo.getWalletCurrency(request: HTTPConnection.openConnection(stringParams: walletCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_WALLET_CURRENCY), completion: {(response , error ) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else if response!.responseCode == 101  {
                    self.onCurrencyList(currencyList: response!.walletCurrencyList)
                } else {
                    self.hideProgress()
                    self.showError(message: response!.description)
                }
            })
            
        } else {
            self.noInternet()
        }
    }
    
    
    @IBAction func btnReceivingCurrency(_ sender:Any) {
        isSendingSelect = false
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        (nextVC as! SelectCountryVC).isShowCurrency = true
        (nextVC as! SelectCountryVC).countryType = CountryParser.RECEIVE
        self.pushWithFullScreen(nextVC)
    }
    
    
    
    @IBAction func btnConvertRates(_ sender:Any) {
        getRates()
    }

    @IBAction func btnBackFunc(_ sender: UIButton) {
        if let tabbar = tabBarController as? CustomTabBarController {
            tabbar.selectedIndex = 0
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func getRates() {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                calRequest.transferAmount = txtFirst.text!
                calRequest.paymentMode = "bank"
                print(calRequest.getXML())
                moneyTransferRepo.getRates(request: HTTPConnection.openConnection(stringParams: calRequest.getXML(), action: SoapActionHelper.shared.ACTION_CAL_TRANSFER), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showRates(response: response!)
                      //  self.showSuccess(message: response!.description!)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        }
       
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        
        let recCurrencyRequest = GetSendRecCurrencyRequest()
        recCurrencyRequest.countryType = country.countryType
        recCurrencyRequest.countryShortName = country.countryShortName
        recCurrencyRequest.languageId = preferenceHelper.getLanguage()
        
        if Network.isConnectedToNetwork() {
            showProgress()
            self.authRepo.getReceiveCurrency(request: HTTPConnection.openConnection(stringParams: recCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_REC_CURRENCY), completion: {(response , error ) in
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
            
        }
        
        txtSecond.text = ""
    }
    
    
    func onSelectCurrency(currency: RecCurrency) {
        if isSendingSelect {
            self.firstDropDown.setTitle(currency.currencyShortName, for: .normal)
            calRequest.payInCurrency = currency.currencyShortName
            calRequest.transferCurrency = currency.currencyShortName
        } else {
            self.secondDropDown.setTitle(currency.currencyShortName, for: .normal)
            calRequest.payoutCurrency = currency.currencyShortName
        }
        txtSecond.text = ""
    }
    
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        if currencyList.count == 1 {
            self.hideProgress()
            if isSendingSelect {
                self.firstDropDown.setTitle(currencyList[0].currencyShortName, for: .normal)
                calRequest.payInCurrency = currencyList[0].currencyShortName
                calRequest.transferCurrency = currencyList[0].currencyShortName
            } else {
                self.secondDropDown.setTitle(currencyList[0].currencyShortName, for: .normal)
                calRequest.payoutCurrency = currencyList[0].currencyShortName
            }
            
        } else {
            self.hideProgress()
            let nextVC = ControllerID.selectCurrencyVC.instance
            (nextVC as! SelectCurrencyVC).currencyProtocol = self
            (nextVC as! SelectCurrencyVC).filteredList = currencyList
            (nextVC as! SelectCurrencyVC).countriesList = currencyList
            self.pushWithFullScreen(nextVC)
        }
    }
    
    
    func showRates(response:CalTransferResponse) {
        txtSecond.text = String(format: "%.02f", response.payoutAmount)
    }

}
