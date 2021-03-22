//
//  BankTransferConverterVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BankTransferConverterVC: BaseVC , CurrencyListProtocol , SourceOFIncomeProtocol , TransferPurposeProtocol {
    
    var beneDetails:BeneficiaryList!
    
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var viewFirstCurrency: UIView!
    @IBOutlet weak var viewSecondCurrency: UIView!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtsecond: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var stackCommission: UIStackView!
    
    @IBOutlet weak var sendingStack: UIStackView!
    @IBOutlet weak var comStack: UIStackView!
    
    @IBOutlet weak var lblPayable: UILabel!
    @IBOutlet weak var lblSendingAmmount: UILabel!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var btnSource: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var viewPromo: UIView!
    @IBOutlet weak var txtPromo: UITextField!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblPayInCurrency:UILabel!
    @IBOutlet weak var lblPayOutCurrency:UILabel!
    @IBOutlet weak var payInFlag:UIImageView!
    @IBOutlet weak var payOutFlag: UIImageView!
    
    @IBOutlet weak var priceBreakDownBtn: UIButton!
    @IBOutlet weak var totalPaylbl: UILabel!
    
    var isPriceViewVisible = false
    var isWalletSelected = false
    var isPurposeSelected = false
    var isSourceOfIncomeSelect = false
    
    var isSendingSelected = false
    @IBOutlet weak var sourceOfincomelbl: UILabel!
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var purposeofTranslbl: UILabel!
    
    @IBOutlet weak var commissionlbl: UILabel!
    @IBOutlet weak var sendingAmountlbl: UILabel!
    
    func isRateValidite() -> Bool {
        if !isWalletSelected {
            self.showError(message: "plz_select_sending_currency".localized)
            return false
        } else if !beneDetails.paymentMode.elementsEqual("bank") {
            if calRequest.payoutCurrency.isEmpty {
                self.showError(message: "plz_select_receiving_currency".localized)
                return false
            }
        }
     
        return true
    }
    
    
    override func isValidate() -> Bool {
        if !isSourceOfIncomeSelect  {
            self.showError(message: "plz_select_source_of_income_error".localized)
            return false
        } else if !isPurposeSelected {
            self.showError(message: "plz_select_send_purpose_error".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if beneDetails.paymentMode == PaymentMode.payment_cash {
            toolTitle.text = "cash_transfer".localized
        } else {
            toolTitle.text = "bank_transfer".localized
        }
        btnConvert.setTitle("convert_string".localized, for: .normal)
        totalPaylbl.text = "total_payable".localized
        sendingAmountlbl.text = "sending_amount".localized
        commissionlbl.text = "commission_amount".localized
        txtPromo.placeholder = "enter_promo_code".localized
        btnApply.setTitle("apply_txt".localized, for: .normal)
        sourceOfincomelbl.text = "source_income".localized
        purposeofTranslbl.text = "purpose_of_transfer".localized
        btnSource.setTitle("select_source_income".localized, for: .normal)
        btnTransfer.setTitle("select_the_purpose_txt".localized, for: .normal)
        btnSendNow.setTitle("send_now".localized, for: .normal)
        priceBreakDownBtn.setTitle("view_price_break_down".localized, for: .normal)
        
        
        comStack.layer.cornerRadius = 8
        sendingStack.layer.cornerRadius = 8
        initDesign()
        payInFlag.makeImageCircle()
        payOutFlag.makeImageCircle()
    }
    
    
    
    @IBAction func btnHidePriceFunc(_ sender: UIButton) {
        if isPriceViewVisible {
            stackCommission.isHidden = true
            isPriceViewVisible = false
            sender.setTitle("view_price_break_down".localized, for: .normal)
        }
        else{
            stackCommission.isHidden = false
            isPriceViewVisible = true
            sender.setTitle("hide_break_down".localized, for: .normal)
        }
    }
    
    
    
    @objc
    func btnSendingCurrency(_ sender:Any) {
        if Network.isConnectedToNetwork() {
            let walletCurrencyRequest = GetWalletCurrencyListRequest()
            walletCurrencyRequest.languageId = preferenceHelper.getApiLangugae()
            showProgress()
            moneyTransferRepo.getWalletCurrency(request: HTTPConnection.openConnection(stringParams: walletCurrencyRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_WALLET_CURRENCY), completion: {(response , error ) in
                if let error = error {
                    self.hideProgress()
                    self.showError(message: error)
                } else if response!.responseCode == 101  {
                    self.isSendingSelected = true
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
    
    
    
    
    @objc func btnReceivingCurrency(_ sender:Any) {
        
        if !beneDetails.paymentMode.elementsEqual("bank") {
            if Network.isConnectedToNetwork() {
                let request = PayoutCurrencyListRequest()
                request.countryShortName = beneDetails.payOutCountryCode
                request.languageID = preferenceHelper.getApiLangugae()
                showProgress()
                moneyTransferRepo.getPayOutCurrency(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_PAY_OUT_CURRENCY),
                                                    completion: {(response , error ) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response == nil {
                        self.showError(message: "Please contact To adminstrator")
                        return
                    } else if response!.responseCode == 101 {
                        self.isSendingSelected = false
                        self.onCurrencyList(currencyList: response!.walletCurrencyList)
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
                
                
            }
        }
        
      
    }
    
    
    @IBAction func btnConvertFunc(_ sender: UIButton) {
        getRates()
    }
    
    @IBAction func btnNowFunc(_ sender: UIButton) {
        if isValidate() {
            if preferenceHelper.getISKYCApproved() {
                TotiPaySend.shared.beneficiaryNo = beneDetails.beneficiaryNo
                TotiPaySend.shared.payInCurrency = calRequest.payInCurrency
                TotiPaySend.shared.payOutCurrency = calRequest.payoutCurrency
                
                TotiPaySend.shared.customerNo = preferenceHelper.getCustomerNo()
   
                let nextVC = ControllerID.summaryVC.instance
                (nextVC as! SummaryVC).beneName = beneDetails.firstName + " " + beneDetails.lastName
                (nextVC as! SummaryVC).totalPayable = lblPayable.text
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
    
    
    @IBAction func btnSourceOfIncome(_ sender:Any) {
        let nextVC = ControllerID.sourceOfIncome.instance
        (nextVC as! SourceOfIncomeVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnTransferPurpose(_ sender:Any) {
        let nextVC = ControllerID.purposeOfTransfer.instance
        (nextVC as! PurposeVC).shortCountryCode = "GBR"
        (nextVC as! PurposeVC).purposeProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    func onSelectSourceOfIncome(sourceOfIncome: SourceOfIncome) {
        btnSource.setTitle(sourceOfIncome.incomeName, for: .normal)
        btnSource.setTitleColor(.black, for: .normal)
        TotiPaySend.shared.sourceOfIncome = sourceOfIncome.id!
        isSourceOfIncomeSelect = true
    }
    
    func onSelectTransferProtocol(purpose: PurposeOfTransfer) {
        btnTransfer.setTitle(purpose.purposeOfTransfer, for: .normal)
        btnTransfer.setTitleColor(.black, for: .normal)
        TotiPaySend.shared.purposeOfTransfer = purpose.purposeOfTransferID!
        isPurposeSelected = true
    }
    
    func onSelectCurrency(currency: RecCurrency) {
        
        if isSendingSelected {
            self.lblPayInCurrency.text =  currency.currencyShortName
            calRequest.payInCurrency = currency.currencyShortName
            calRequest.transferCurrency = currency.currencyShortName
            isWalletSelected = true
            payInFlag.sd_setImage(with: URL(string: currency.image_URL), placeholderImage: UIImage(named: "flag"))
            payInFlag.makeImageCircle()
        } else if !isSendingSelected {
            self.lblPayOutCurrency.text =  currency.currencyShortName
            calRequest.payoutCurrency = currency.currencyShortName
            payOutFlag.sd_setImage(with: URL(string: currency.image_URL), placeholderImage: UIImage(named: "flag"))
            payOutFlag.makeImageCircle()
        }
        
        hideViews()
        txtsecond.text = ""
        txtFirst.text = ""
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
//        if currencyList.count == 1 {
//            self.hideProgress()
//
//            self.lblPayInCurrency.text =  currencyList[0].currencyShortName
//            calRequest.payInCurrency = currencyList[0].currencyShortName
//            calRequest.transferCurrency = currencyList[0].currencyShortName
//            isWalletSelected = true
//
//        } else {
            self.hideProgress()
            let nextVC = ControllerID.selectCurrencyVC.instance
            (nextVC as! SelectCurrencyVC).currencyProtocol = self
            (nextVC as! SelectCurrencyVC).filteredList = currencyList
            (nextVC as! SelectCurrencyVC).countriesList = currencyList
            self.pushWithFullScreen(nextVC)
       // }
        txtsecond.text = ""
        txtFirst.text = ""
     //   hideViews()
    }
    
    
    func getRates() {
        if isRateValidite() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                if txtFirst.text!.isEmpty && txtsecond.text!.isEmpty {
                    self.showError(message: "please_enter_amount".localized)
                    return
                } else if !txtFirst.text!.isEmpty {
                    calRequest.transferCurrency = lblPayInCurrency.text!
                    calRequest.transferAmount = txtFirst.text!
                } else if !txtsecond.text!.isEmpty {
                    calRequest.transferCurrency = lblPayOutCurrency.text!
                    calRequest.transferAmount = txtsecond.text!
                }
                calRequest.languageId = preferenceHelper.getApiLangugae()
                calRequest.paymentMode = beneDetails.paymentMode
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
    
    
    func showRates(response:CalTransferResponse) {
        if(calRequest.payInCurrency.elementsEqual(calRequest.payoutCurrency)) {
            if !txtFirst.text!.isEmpty {
                txtsecond.text = String(format: "%.02f", response.payoutAmount)
            } else if !txtsecond.text!.isEmpty {
                txtFirst.text = String(format: "%.02f", response.payInAmount)
            }
        }
        
        else if calRequest.payInCurrency.elementsEqual(calRequest.transferCurrency) {
            txtsecond.text = String(format: "%.02f", response.payoutAmount)
        } else if calRequest.payoutCurrency.elementsEqual(calRequest.transferCurrency) {
            txtFirst.text = String(format: "%.02f", response.payInAmount)
        }
        lblPayable.text = String(format: "%.02f", response.totalPayable)
        lblSendingAmmount.text = String(format: "%.02f", response.payInAmount)
        lblCommission.text = String(format: "%.02f", response.commission)
        TotiPaySend.shared.transferAmount = String(response.payoutAmount)
        showViews()
    }
    
    func initDesign() {
        viewFirstCurrency.layer.cornerRadius = 8
        viewSecondCurrency.layer.cornerRadius = 8
        
        txtFirst.layer.cornerRadius = 8
        txtsecond.layer.cornerRadius = 8
        
        txtFirst.setLeftPaddingPoints(10)
        txtsecond.setLeftPaddingPoints(10)
        
        
        txtFirst.delegate = self
        txtsecond.delegate = self
        
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnSendNow.layer.cornerRadius = 8
        
        viewPromo.layer.cornerRadius = 8
        btnApply.layer.cornerRadius = 8
        btnApply.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnSource.layer.cornerRadius = 8
        btnTransfer.layer.cornerRadius = 8
        btnSendNow.layer.cornerRadius = 8
        
        btnSource.imageEdgeInsets.left = self.btnSource.frame.width - 0
        btnTransfer.imageEdgeInsets.left = self.btnTransfer.frame.width - 0
        
        viewPromo.layer.borderWidth = 0.5
        viewPromo.layer.borderColor = UIColor.black.cgColor
        
        txtPromo.setLeftPaddingPoints(10)
        
        let currencyGesture = UITapGestureRecognizer(target: self, action: #selector(btnSendingCurrency(_:)))
        viewFirstCurrency.addGestureRecognizer(currencyGesture)
        
        
        let receivingCurrencyGesture = UITapGestureRecognizer(target: self, action: #selector(btnReceivingCurrency(_:)))
        viewSecondCurrency.addGestureRecognizer(receivingCurrencyGesture)
        
        lblPayOutCurrency.text = beneDetails.payOutCurrency
        
        payOutFlag.sd_setImage(with: URL(string: beneDetails.imageURL), placeholderImage: UIImage(named: "flag"))
        calRequest.payoutCurrency = beneDetails.payOutCurrency
        calRequest.payInCountry = preferenceHelper.getResidenseCountry()
        calRequest.payOutCountry = beneDetails.payOutCountryCode
        if beneDetails.paymentMode.elementsEqual("bank") {
            //need to disable the click
        }
    }
    
    
    func showViews() {
        viewBottom.isHidden = false
        btnConvert.isHidden = true
    }
    
    func hideViews() {
        viewBottom.isHidden = true
        btnConvert.isHidden = false
    }
    
}
extension BankTransferConverterVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
     //   if string.count > 0 { // if it was not delete character
            hideViews()
           // txtsecond.text = "0.00"
     //   }
        if textField.tag == 1 {
            txtsecond.placeholder = "0.00"
            txtsecond.text = ""
        } else if textField.tag == 2 {
            txtFirst.placeholder = "0.00"
            txtFirst.text = ""
        }
        return true
    }
    
}
