//
//  PaymentOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PaymentOptionVC: BaseVC  , PinVerifiedProtocol , CardSumitProtocol {
 
   
    
    
    let moneyRepo:MoneyTransferRepository = MoneyTransferRepository()
    let repo:Repository = Repository()
    
    
    var cardsList:[CardDetails] = Array()
    
    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var viewBankAccount: UIView!
    
    @IBOutlet weak var walletNameLbl:UILabel!
    @IBOutlet weak var walletBalancelbl:UILabel!
    @IBOutlet weak var payThroughCard:UILabel!
    
    
    
    var isTableViewVisiable = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        viewWallet.layer.cornerRadius = 8
        btnLoad.layer.cornerRadius = 8
        cardTableView.layer.cornerRadius = 8
        viewBankAccount.layer.cornerRadius = 8
        getWalletDetails()
        let viewBankAccountGesture = UITapGestureRecognizer(target: self, action: #selector(viewBankAccountFunc(_:)))
        viewBankAccount.addGestureRecognizer(viewBankAccountGesture)
        
        let viewWalletGesture = UITapGestureRecognizer(target: self, action: #selector(payThroughWallet(_:)))
        viewWallet.addGestureRecognizer(viewWalletGesture)
        
        let viewPaythroughCard = UITapGestureRecognizer(target: self, action: #selector(payThorughCard(_:)))
        payThroughCard.addGestureRecognizer(viewPaythroughCard)
        
    }
    
    @objc private func viewBankAccountFunc(_ sender: UIGestureRecognizer) {
        
    }
    
    @objc func payThroughWallet(_ sender:UIGestureRecognizer) {
        TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.WALLET
        TotiPaySend.shared.cardNumber = ""
        TotiPaySend.shared.expireDate = ""
        TotiPaySend.shared.securityNumber = ""
        getPin()
    }
    
    @objc func payThorughCard(_ sender : UIGestureRecognizer) {
        let nextVC = ControllerID.cardDetailVC.instance
        (nextVC as! CardDetailVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }

    
    @IBAction func btnLoadFunc(_ sender: UIButton) {
       getCustomerCards()
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getPin() {
        let nextVC = ControllerID.verifyTransferPinVC.instance
        (nextVC as! VerifyTransferPinVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    func onPinVerified(action: Bool) {
        if action {
            loadWallet()
        }
    }
    
    
    func onAddCardDetails(cardNumber: String, cardExpire: String, cardCVV: String) {
        TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.WALLET
        TotiPaySend.shared.cardNumber = cardNumber
        TotiPaySend.shared.expireDate = cardExpire
        TotiPaySend.shared.securityNumber = cardCVV
        getPin()
    }
    
    
    func loadWallet() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            print(TotiPaySend.shared.getXML())
            moneyRepo.sendTotiPay(request: HTTPConnection.openConnection(stringParams: TotiPaySend.shared.getXML(), action: SoapActionHelper.shared.ACTION_SEND_TRANSFER), completion: {(response , error)  in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.CREDIT_CARD {
                        
                    } else if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.BANK_DEPOSIT {
                        
                    } else if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.WALLET {
                        self.goToReceipt(number: response!.transactionNo!)
                    }
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }
    
    
    func goToReceipt(number:String) {
        print(number)
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
                    self.showSuccess(message: response!.description!)
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
    
   
}

//MARK : TableView Functions
extension PaymentOptionVC: UITableViewDelegate, UITableViewDataSource {
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
       
    }
    
    

    
    func getWalletDetails() {
        if Network.isConnectedToNetwork() {
            let request = WalletBalanceRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageId = preferenceHelper.getLanguage()
            request.walletCurrency = TotiPaySend.shared.payInCurrency
            
            showProgress()
            moneyRepo.getWalletBalance(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_WALLET_BALANCE), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.walletNameLbl.text = "Wallet \(TotiPaySend.shared.payInCurrency)"
                    self.walletBalancelbl.text = response!.walletBalance
                } else {
                    self.showError(message: response!.description)
                }
            })
            
        } else {
            self.noInternet()
        }
    }
    
    
    
    
}
