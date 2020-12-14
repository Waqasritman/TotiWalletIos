//
//  RepeatWalletTransactionVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/13/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class RepeatWalletTransactionVC:  BaseVC ,  CountryListProtocol , CurrencyListProtocol
                                  , OnConfirmSummaryProtocol , PinVerifiedProtocol {

    
    var isSendingSelect = false
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let authRepo:AuthRepository = AuthRepository()
    var history:WalletHistory!
    
    
    let walletTransferRequest:WalletToWalletTransferRequest = WalletToWalletTransferRequest()
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var firstDropDown: UIButton!
    @IBOutlet weak var secondDropDown: UIButton!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var lblCommision: UILabel!
  
    @IBOutlet weak var commissionView: UIStackView!
    @IBOutlet weak var dataViewStack: UIStackView!
    
    
    override func isValidate() -> Bool {
        if txtPhoneNumber.text!.isEmpty {
            showError(message: "Enter number")
            return false
        }  else if txtName.text!.isEmpty {
            showError(message: "Enter Wallet name")
            return false
        }
        return true
    }
    
    
    func isRateValidate() -> Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnSendNow.layer.cornerRadius = 8
        
        firstDropDown.layer.cornerRadius = 8
        secondDropDown.layer.cornerRadius = 8
        
        firstDropDown.imageEdgeInsets.left = self.firstDropDown.frame.width - 25
        secondDropDown.imageEdgeInsets.left = self.secondDropDown.frame.width - 25
        
        txtFirst.layer.cornerRadius = 8
        txtSecond.layer.cornerRadius = 8
        
        txtName.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        
        txtFirst.setLeftPaddingPoints(10)
        txtSecond.setLeftPaddingPoints(10)
        
        txtPhoneNumber.setLeftPaddingPoints(5)

        txtPhoneNumber.text = history.receiverNumber
        txtPhoneNumber.isEnabled = false

    }
    
    
    
    
    
    @IBAction func btnSendingCurrency(_ sender:Any) {
        isSendingSelect = true
        getWalletCurrencies()
    }
    
    
    @IBAction func btnReceivingCurrency(_ sender:Any) {
        isSendingSelect = false
        getWalletCurrencies()
    }
    
    
    @IBAction func btnConvertFunc(_ sender: UIButton) {
        self.getRates()
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnSendNowFunc(_ sender: UIButton) {
        if isValidate() {
            walletTransferRequest.customerNo = preferenceHelper.getCustomerNo()
            walletTransferRequest.description = txtDescription.text!
            walletTransferRequest.payInCurrency = calRequest.payInCurrency
            walletTransferRequest.receiptCurrency = calRequest.payoutCurrency
            walletTransferRequest.receiptMobileNo = self.txtPhoneNumber.text!
            walletTransferRequest.transferAmount = calRequest.transferAmount
            walletTransferRequest.languageId = preferenceHelper.getLanguage()
            let nextVC = ControllerID.verifyTransferDetailVC.instance
            (nextVC  as! VerifyTransferDetailVC).walletRequest = walletTransferRequest
            (nextVC as! VerifyTransferDetailVC).protocolConfirm = self
            (nextVC as! VerifyTransferDetailVC).walletName = txtName.text!
            self.pushWithFullScreen(nextVC)
        }
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getWalletCurrencies() {
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
    
    func getRates() {
        if isRateValidate() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                calRequest.transferAmount = txtFirst.text!
                calRequest.paymentMode = PaymentMode.wallet_mode
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
    
    
    func onConfirmSummary() {
        let nextVC = ControllerID.verifyTransferPinVC.instance
        (nextVC as! VerifyTransferPinVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    func onPinVerified(action: Bool) {
        if action {
            walletTransfer()
        }
    }
    
    
    
    func showRates(response:CalTransferResponse) {
        txtSecond.text = String(format: "%.02f", response.payoutAmount)
        lblCommision.text = String(format: "%.02f", response.commission)
        showViews()
    }
    
    
    func walletTransfer() {
        if preferenceHelper.getISKYCApproved() {
            if Network.isConnectedToNetwork() {
                showProgress()
                moneyTransferRepo.walletToWallet(request: HTTPConnection.openConnection(stringParams: walletTransferRequest.getXML(), action: SoapActionHelper.shared.ACTION_WALLET_TO_WALLET), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showAlert(title: "successfully_tranfared".localizedLowercase, message: "wallet_traansaction_success".localizedLowercase)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            }
        }else {
            
        }
    }
    
    
    func hideViews() {
        viewBottom.isHidden = true
        btnConvert.isHidden = false
    }
    
    
    func showViews() {
        viewBottom.isHidden = false
        btnConvert.isHidden = true
    }
    
}
