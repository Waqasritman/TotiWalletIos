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
    @IBOutlet weak var firstDropDown: UILabel!
    @IBOutlet weak var secondDropDown: UILabel!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var sendingIcon:UIImageView!
    @IBOutlet weak var receivingIcon:UIImageView!
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var sendingView:UIView!
    @IBOutlet weak var receivingView:UIView!
    
    
    override func isValidate() -> Bool {
        if calRequest.payInCurrency.isEmpty {
            self.showError(message: "plz_select_sending_currency".localized)
            return false
        } else if calRequest.payoutCurrency.isEmpty {
            self.showError(message: "plz_select_receiving_currency".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFirst.delegate = self
        txtSecond.delegate = self
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnTransferNow.layer.cornerRadius = 8
        
        sendingView.layer.cornerRadius = 8
        receivingView.layer.cornerRadius = 8
        txtFirst.layer.cornerRadius = 8
        txtSecond.layer.cornerRadius = 8
        
        
        txtFirst.setLeftPaddingPoints(10)
        txtSecond.setLeftPaddingPoints(10)
        
        
        toolTitle.text = "best_rate".localized
        btnConvert.setTitle("convert_string".localized, for: .normal)
        btnTransferNow.setTitle("transfer_now".localized, for: .normal)
        
        
        let sendingGes = UITapGestureRecognizer.init(target: self, action: #selector(btnSendingCurrency(_:)))
        sendingView.addGestureRecognizer(sendingGes)
        
        
        let receivingGes = UITapGestureRecognizer.init(target: self, action: #selector(btnReceivingCurrency(_:)))
        receivingView.addGestureRecognizer(receivingGes)
        
        sendingIcon.makeImageCircle()
        receivingIcon.makeImageCircle()
        
    }
    
    @objc func btnSendingCurrency(_ sender:UITapGestureRecognizer) {
        isSendingSelect = true
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        (nextVC as! SelectCountryVC).isShowCurrency = true
        (nextVC as! SelectCountryVC).countryType = CountryParser.SEND
        self.pushWithFullScreen(nextVC)
        //        if Network.isConnectedToNetwork() {
        //            let walletCurrencyRequest = GetWalletCurrencyListRequest()
        //            walletCurrencyRequest.languageId = preferenceHelper.getApiLangugae()
        //            showProgress()
        //            moneyTransferRepo.getWalletCurrency(request: HTTPConnection.openConnection(stringParams: walletCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_WALLET_CURRENCY), completion: {(response , error ) in
        //                if let error = error {
        //                    self.hideProgress()
        //                    self.showError(message: error)
        //                } else if response!.responseCode == 101  {
        //                    self.onCurrencyList(currencyList: response!.walletCurrencyList)
        //                } else {
        //                    self.hideProgress()
        //                    self.showError(message: response!.description)
        //                }
        //            })
        //
        //        } else {
        //            self.noInternet()
        //        }
    }
    
    
    @objc func btnReceivingCurrency(_ sender:UITapGestureRecognizer) {
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
    
    
    @IBAction func btnTransferNow(_ sender:Any) {
        let nextVC = ControllerID.quickPayVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    func getRates() {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                
                if txtFirst.text!.isEmpty && txtSecond.text!.isEmpty {
                    self.showError(message: "please_enter_amount".localized)
                    return
                } else if !txtFirst.text!.isEmpty {
                    calRequest.transferCurrency = firstDropDown.text!
                    calRequest.transferAmount = txtFirst.text!
                } else if !txtSecond.text!.isEmpty {
                    calRequest.transferCurrency = secondDropDown.text!
                    calRequest.transferAmount = txtSecond.text!
                }
                
                
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
        if isSendingSelect {
            self.firstDropDown.text = country.currencyShortName
            calRequest.payInCurrency = country.currencyShortName
          //  calRequest.transferCurrency = country.currencyShortName
            sendingIcon.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
        } else {
            self.secondDropDown.text =  country.currencyShortName
            self.secondDropDown.textColor = .black
            calRequest.payoutCurrency = country.currencyShortName
            receivingIcon.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
        }
        
        // countryFlag.makeImageCircle()
        txtSecond.text = ""
        txtFirst.text = ""
    }
    
    
    func onSelectCurrency(currency: RecCurrency) {
        if isSendingSelect {
            self.firstDropDown.text = currency.currencyShortName
            calRequest.payInCurrency = currency.currencyShortName
            calRequest.transferCurrency = currency.currencyShortName
            sendingIcon.sd_setImage(with: URL(string: currency.image_URL), placeholderImage: UIImage(named: "flag"))
        }
        txtSecond.text = ""
    }
    
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        if currencyList.count == 1 {
            self.hideProgress()
            if isSendingSelect {
                self.firstDropDown.text = currencyList[0].currencyShortName
                calRequest.payInCurrency = currencyList[0].currencyShortName
                calRequest.transferCurrency = currencyList[0].currencyShortName
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
        if(calRequest.payInCurrency.elementsEqual(calRequest.payoutCurrency)) {
            if !txtFirst.text!.isEmpty {
                txtSecond.text = String(format: "%.02f", response.payoutAmount)
            } else if !txtSecond.text!.isEmpty {
                txtFirst.text = String(format: "%.02f", response.payInAmount)
            }
        } else if calRequest.payInCurrency.elementsEqual(calRequest.transferCurrency) {
            txtSecond.text = String(format: "%.02f", response.payoutAmount)
        } else if calRequest.payoutCurrency.elementsEqual(calRequest.transferCurrency) {
            txtFirst.text = String(format: "%.02f", response.payInAmount)
        }
       
    }
    
}
extension OurRatesVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        if textField.tag == 1 {
            txtSecond.placeholder = "0.00"
            txtSecond.text = ""
        } else if textField.tag == 2 {
            txtFirst.placeholder = "0.00"
            txtFirst.text = ""
        }
        
     
        return true
    }
    
}
