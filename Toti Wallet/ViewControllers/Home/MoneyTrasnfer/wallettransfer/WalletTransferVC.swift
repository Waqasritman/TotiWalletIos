//
//  WalletTransferVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class WalletTransferVC: BaseVC ,  CountryListProtocol , CurrencyListProtocol
                        , OnConfirmSummaryProtocol , PinVerifiedProtocol {
    
    var isSendingSelect = false
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let authRepo:AuthRepository = AuthRepository()
    let repo : Repository = Repository()
    var isOwnWallet:Bool = false
    let walletTransferRequest:WalletToWalletTransferRequest = WalletToWalletTransferRequest()
    
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var firstDropDown: UILabel!
    @IBOutlet weak var secondDropDown: UILabel!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var viewBottom: UIStackView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var lblCommision: UILabel!
    @IBOutlet weak var lblCode:UILabel!
    
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var commissionStack: UIStackView!
    
    @IBOutlet weak var dataStack: UIStackView!

    @IBOutlet weak var receivingView: UIView!
    @IBOutlet weak var sendingView: UIView!
    @IBOutlet weak var receivingIcon: UIImageView!
    @IBOutlet weak var sendingIcon: UIImageView!
    @IBOutlet weak var countryVIew: UIView!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var tooltitle: UILabel!
    @IBOutlet weak var commlbl: UILabel!
    @IBOutlet weak var numberStack: UIStackView!
    
    @IBOutlet weak var mobilelbl: UILabel!
    @IBOutlet weak var walletnamelbl: UILabel!
    @IBOutlet weak var descriptionbl: UILabel!
    
    override func isValidate() -> Bool {
        if isOwnWallet {
            return true
        }
        if lblCode.text!.isEmpty {
            showError(message: "plz_select_country_code".localized)
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            showError(message: "enter_mobile_no_error".localized)
            return false
        } else if !verifyNumber(number: lblCode.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        } else if txtName.text!.isEmpty {
            showError(message: "recever_name_error".localized)
            return false
        } else if !preferenceHelper.getISKYCApproved() {
            showError(message: "plz_complete_kyc".localized)
            return false
        }
        return true
    }
    
    func isRateValidate() -> Bool {
         if calRequest.payInCurrency.isEmpty {
            self.showError(message: "plz_select_sending_currency".localized)
            return false
        } else if calRequest.payoutCurrency.isEmpty {
            self.showError(message: "plz_select_receiving_currency".localized)
            return false
        }
        return true
    }
    
    
    
    func isNumberValidate() -> Bool {
        if isOwnWallet {
            return true
        }
        if lblCode.text!.isEmpty {
            showError(message: "plz_select_country_code".localized)
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            showError(message: "enter_mobile_no_error".localized)
            return false
        } else if !verifyNumber(number: lblCode.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFirst.delegate = self
        txtSecond.delegate = self
        txtPhoneNumber.delegate = self
        btnConvert.setTitle("convert_string".localized, for: .normal)
        pageTitle.text = "send_moeny_to_wallet".localized
        tooltitle.text = "wallet_transfer".localized
        commlbl.text = "commission_amount".localized
        mobilelbl.text = "mobile_number".localized
        walletnamelbl.text = "wallet_name".localized
        descriptionbl.text = "description_txt_optional".localized
        txtDescription.placeholder = "wallet_des_hint".localized
        btnSendNow.setTitle("send_now".localized, for: .normal)
      //  txtSecond.isEnabled = false
        
        
        txtPhoneNumber.placeholder = "phone_number_hint".localized
        txtName.placeholder = "name_hint".localized
        
        
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnSendNow.layer.cornerRadius = 8
        
        sendingView.layer.cornerRadius = 8
        receivingView.layer.cornerRadius = 8
        sendingIcon.makeImageCircle()
        receivingIcon.makeImageCircle()
      
        countryVIew.layer.cornerRadius = 8
        txtFirst.layer.cornerRadius = 8
        txtSecond.layer.cornerRadius = 8
        
        txtName.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        
        txtFirst.setLeftPaddingPoints(10)
        txtSecond.setLeftPaddingPoints(10)
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        countryFlag.makeImageCircle()
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
        let sendingGes = UITapGestureRecognizer(target: self, action: #selector(btnSendingCurrency(_:)))
        sendingView.addGestureRecognizer(sendingGes)
        
        let receivingGes = UITapGestureRecognizer(target: self, action: #selector(btnReceivingCurrency(_:)))
        receivingView.addGestureRecognizer(receivingGes)
        
        
        txtSecond.isEnabled = false
        if isOwnWallet {
            numberStack.isHidden = true
        }
    }
    

    @objc func btnSendingCurrency(_ sender:Any) {
        isSendingSelect = true
        //getWalletCurrencies()
        getCustomerWallets(wallet: preferenceHelper.getCustomerNo(),
                           actionType: CCYWalletActionType.RECEIVE)
    }
    
    
    @objc func btnReceivingCurrency(_ sender:Any) {
        isSendingSelect = false
      //  getWalletCurrencies()
        if isOwnWallet {
            getCustomerWallets(wallet: preferenceHelper.getCustomerNo(),
                               actionType: CCYWalletActionType.RECEIVE)
        } else {
            if isNumberValidate() {
                getCustomerWallets(wallet: String().removePlus(number: lblCode.text! + txtPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)),
                                   actionType: CCYWalletActionType.RECEIVE)
            }
           
        }
    
    }
    
    
    @IBAction func btnConvertFunc(_ sender: UIButton) {
        if isNumberValidate() {
            self.getRates()
        }
      
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnSendNowFunc(_ sender: UIButton) {
        if isValidate() {
            if preferenceHelper.getISKYCApproved() {
                print(preferenceHelper.getPhoneForKYC())
                if !isOwnWallet {
                    walletTransferRequest.receiptMobileNo = String().removePlus(number: self.lblCode.text!
                                                                                    + self.txtPhoneNumber.text!)
                } else {
                    walletTransferRequest.receiptMobileNo = String().removePlus(number:
                                                                                    preferenceHelper.getPhoneForKYC())
                }
                
                
                walletTransferRequest.customerNo = preferenceHelper.getCustomerNo()
                walletTransferRequest.description = txtDescription.text!
                walletTransferRequest.payInCurrency = calRequest.payInCurrency
                walletTransferRequest.receiptCurrency = calRequest.payoutCurrency
                
                walletTransferRequest.transferAmount = txtFirst.text!
                walletTransferRequest.languageId = preferenceHelper.getApiLangugae()
                let nextVC = ControllerID.verifyTransferDetailVC.instance
                (nextVC  as! VerifyTransferDetailVC).walletRequest = walletTransferRequest
                (nextVC as! VerifyTransferDetailVC).protocolConfirm = self
                if !isOwnWallet {
                    (nextVC as! VerifyTransferDetailVC).walletName = txtName.text!
                }else{
                    (nextVC as! VerifyTransferDetailVC).walletName = preferenceHelper.getCustomerName()
                }
                self.pushWithFullScreen(nextVC)
            } else {
                self.showError(message: "plz_complete_kyc".localized)
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
    
    
    
    func getCustomerWallets(wallet:String , actionType:String) {
        if Network.isConnectedToNetwork() {
            let request = GetCCYForWalletRequest()
            request.customerNo = wallet
            request.actionType = actionType
            request.languageID = preferenceHelper.getApiLangugae()
            self.showProgress()
            repo.getCCYWallets(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_ADD_CCY_WALLET), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.onCurrencyList(currencyList: response!.walletCurrencyList)
                } else if response!.description != nil {
                    self.showError(message: response!.description)
                } else {
                    self.showError(message: "something went wrong")
                }
            })
        }
    }
    
    
    func getWalletCurrencies() {
        if Network.isConnectedToNetwork() {
            let walletCurrencyRequest = GetWalletCurrencyListRequest()
            walletCurrencyRequest.languageId = preferenceHelper.getApiLangugae()
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
                calRequest.paymentMode = PaymentMode.wallet_mode
                
                calRequest.payInCountry = preferenceHelper.getResidenseCountry()
                calRequest.payOutCountry = preferenceHelper.getResidenseCountry()
                
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
        lblCode.text = country.countryCode
        countryFlag.sd_setImage(with: URL(string: country.url), placeholderImage: UIImage(named: "flag"))
        countryFlag.makeImageCircle()
        hideViews()
        txtSecond.text = "0.00"
    }
    
    
    func onSelectCurrency(currency: RecCurrency) {
        if isSendingSelect {
            self.firstDropDown.text = currency.currencyShortName
            calRequest.payInCurrency = currency.currencyShortName
            calRequest.transferCurrency = currency.currencyShortName
            sendingIcon.sd_setImage(with: URL(string: currency.image_URL))
            sendingIcon.makeImageCircle()
        } else {
            self.secondDropDown.text = currency.currencyShortName
            self.secondDropDown.textColor = .black
            receivingIcon.sd_setImage(with: URL(string: currency.image_URL))
            receivingIcon.makeImageCircle()
            calRequest.payoutCurrency = currency.currencyShortName
        }
        hideViews()
        txtSecond.text = ""
        txtFirst.text = ""
    }
    
    
    func onCurrencyList(currencyList: [RecCurrency]) {
//        if currencyList.count == 1 {
//            self.hideProgress()
//            if isSendingSelect {
//                self.firstDropDown.text =  currencyList[0].currencyShortName
//                calRequest.payInCurrency = currencyList[0].currencyShortName
//                calRequest.transferCurrency = currencyList[0].currencyShortName
//                sendingIcon.sd_setImage(with: URL(string: currencyList[0].image_URL), placeholderImage: UIImage(named: "flag"))
//                sendingIcon.makeImageCircle()
//            } else {
//                self.secondDropDown.text = currencyList[0].currencyShortName
//                self.secondDropDown.textColor = .black
//                calRequest.payoutCurrency = currencyList[0].currencyShortName
//                receivingIcon.sd_setImage(with: URL(string: currencyList[0].image_URL), placeholderImage: UIImage(named: "flag"))
//                receivingIcon.makeImageCircle()
//            }
//
//        } else {
            self.hideProgress()
            let nextVC = ControllerID.selectCurrencyVC.instance
            (nextVC as! SelectCurrencyVC).currencyProtocol = self
            (nextVC as! SelectCurrencyVC).filteredList = currencyList
            (nextVC as! SelectCurrencyVC).countriesList = currencyList
            self.pushWithFullScreen(nextVC)
       // }
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
        if(calRequest.payInCurrency.elementsEqual(calRequest.payoutCurrency)) {
            if !txtFirst.text!.isEmpty {
                txtSecond.text = String(format: "%.02f", response.payoutAmount)
            } else if !txtSecond.text!.isEmpty {
                txtFirst.text = String(format: "%.02f", response.payInAmount)
            }
        }
        
        else if calRequest.payInCurrency.elementsEqual(calRequest.transferCurrency) {
            txtSecond.text = String(format: "%.02f", response.payoutAmount)
        } else if calRequest.payoutCurrency.elementsEqual(calRequest.transferCurrency) {
            txtFirst.text = String(format: "%.02f", response.payInAmount)
        }
        lblCommision.text = String(format: "%.02f", response.commission)
        if !isOwnWallet {
            showViews()
        } else {
            showViews()
            commissionStack.isHidden = false
            dataStack.isHidden = true
        }
        
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
                        preferenceHelper.isWalletNeedToUpdate(isNeed: true)
                        self.showAlert(title: "successfully_tranfared".localized, message: "wallet_traansaction_success".localized , hidebtn: true)
                    } else if response!.description != nil {
                        self.showError(message: response!.description!)
                    } else {
                        self.showError(message: "Please contact administrator something went wrong")
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
extension WalletTransferVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       // if string.count > 0 { // if it was not delete character
            hideViews()
            //txtSecond.text = "0.00"
        //}
        
        if textField.tag == 5 {
            self.secondDropDown.text = "YER"
            self.receivingIcon.image = UIImage(named: "yemen")
            self.secondDropDown.textColor = .gray
            calRequest.payoutCurrency = ""
        }
        if textField.tag == 10 {
            txtSecond.placeholder = "0.00"
            txtSecond.text = ""
        } else if textField.tag == 2 {
            txtFirst.placeholder = "0.00"
            txtFirst.text = ""
        }
        return true
    }
    
}
