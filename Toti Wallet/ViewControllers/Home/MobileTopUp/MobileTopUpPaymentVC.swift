//
//  MobileTopUpPaymentVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MobileTopUpPaymentVC: BaseVC , CurrencyListProtocol , CardSumitProtocol
                            , AlertViewWithTextProtocol {

    let repo:Repository = Repository()
    let calRequest:CalTransferRequest = CalTransferRequest()
    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    let utilityRepo:UtilityRepository = UtilityRepository()
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var btnProcced: UIButton!
    @IBOutlet weak var payableStack: UIStackView!
    @IBOutlet weak var payablelbl: UILabel!
    @IBOutlet weak var pageTitlelbl: UILabel!
  
    var cardsList:[CardDetails] = Array()
    
    
    var isPaymentMethiodSelected = false
 
    override func isValidate() -> Bool {
       
        return true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        btnLoad.layer.cornerRadius = 8
        btnWallet.layer.cornerRadius = 8
        
        btnWallet.imageEdgeInsets.left = self.view.frame.width - 50
        
        btnProcced.layer.cornerRadius = 8
        
    }
    
    
    @IBAction func btnCustomerWallet(_ sender:UIButton) {
        self.getWalletCurrencies()
    }
    
    
 
    
    @IBAction func btnLoadFunc(_ sender: UIButton) {
        getCustomerCards()
    }
    
    @IBAction func btnProccedFunc(_ sender: UIButton) {
        
        if preferenceHelper.getISKYCApproved() {
            if isPaymentMethiodSelected {
                prepaidCharge()
            } else {
                self.showError(message: "Select Wallet")
            }
        } else {
            self.showError(message: "KYC Error")
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
    
    @IBAction
    func payThorughCard(_ sender : UIButton) {
        let nextVC = ControllerID.cardDetailVC.instance
        (nextVC as! CardDetailVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    func handleAction(txtFieldValue: String) {
        WRPrepaidRechargeRequest.shared.securityCode = txtFieldValue
        isPaymentMethiodSelected = true
        getRates()
    }
    
    
    func onAddCardDetails(cardNumber: String, cardExpire: String, cardCVV: String) {
        WRPrepaidRechargeRequest.shared.cardNumber = cardNumber
        WRPrepaidRechargeRequest.shared.expireDate = cardExpire
        WRPrepaidRechargeRequest.shared.securityCode = cardCVV
        WRPrepaidRechargeRequest.shared.payInCurrency = "GBP"
        WRPrepaidRechargeRequest.shared.paymentTypeId = String(PaymentTypes.shared.CREDIT_CARD)
        isPaymentMethiodSelected = false
        getRates()
    }
    
    func onSelectCurrency(currency: RecCurrency) {
        self.btnWallet.setTitle(currency.currencyShortName, for: .normal)
        self.btnWallet.setTitleColor(.black, for: .normal)
        calRequest.payInCurrency = currency.currencyShortName
        isPaymentMethiodSelected = true
        WRPrepaidRechargeRequest.shared.cardNumber = ""
        WRPrepaidRechargeRequest.shared.expireDate = ""
        WRPrepaidRechargeRequest.shared.securityCode = ""
        WRPrepaidRechargeRequest.shared.paymentTypeId = String(PaymentTypes.shared.WALLET)
        WRPrepaidRechargeRequest.shared.payInCurrency = currency.currencyShortName
        
        
        getRates()
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        if currencyList.count == 1 {
            self.hideProgress()
            self.btnWallet.setTitle(currencyList[0].currencyShortName, for: .normal)
            calRequest.payInCurrency = currencyList[0].currencyShortName
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
        payablelbl.text = String(format: "%.02f", response.totalPayable) + " " + WRPrepaidRechargeRequest.shared.payInCurrency
        payableStack.isHidden = false
    }

}

//MARK : TableView Functions
extension MobileTopUpPaymentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        cell.lblCardNumber.text = cardsList[indexPath.row].cardNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WRPrepaidRechargeRequest.shared.cardNumber = cardsList[indexPath.row].cardNumber
        WRPrepaidRechargeRequest.shared.expireDate = cardsList[indexPath.row].cardExpireDate
        WRPrepaidRechargeRequest.shared.paymentTypeId = String(PaymentTypes.shared.CREDIT_CARD)
        WRPrepaidRechargeRequest.shared.payInCurrency = "GBP"
        AlertViewWithTextField.instance.delegate = self
        AlertViewWithTextField.instance.showAlert(title: "enter_cvv", txtFieldPlaceHolder: "CVV")
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
      
            if Network.isConnectedToNetwork() {
                self.showProgress()
                calRequest.payoutCurrency = WRPrepaidRechargeRequest.shared.payoutCurrency
                calRequest.transferCurrency = WRPrepaidRechargeRequest.shared.payoutCurrency
                calRequest.transferAmount = WRPrepaidRechargeRequest.shared.payOutAmount
                calRequest.paymentMode = PaymentMode.pay_bill
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
    

    func getCustomerCards() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let request = GetCardDetailsRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getLanguage()
            repo.loadCustomerCards(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CARD_DETAILS), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.cardsList.removeAll()
                    self.cardsList.append(contentsOf: response!.cardDetails)
                    self.cardTableView.reloadData()
                    self.cardTableView.isHidden = false
                    self.btnLoad.isHidden = true
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }
    
    
    func prepaidCharge() {
        if Network.isConnectedToNetwork() {
            showProgress()
            WRPrepaidRechargeRequest.shared.customerNo = preferenceHelper.getCustomerNo()
            WRPrepaidRechargeRequest.shared.languageId = preferenceHelper.getLanguage()
            
            utilityRepo.prepaidCharge(request: HTTPConnection.openConnection(stringParams: WRPrepaidRechargeRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_WR_PERPAID_RECHARGE), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    let nextVC = ControllerID.mobileTopUpSuccessVC.instance
                    (nextVC as! MobileTopUpSuccessVC).status = response!.rechargeId
                    self.pushWithFullScreen(nextVC)
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }
}
