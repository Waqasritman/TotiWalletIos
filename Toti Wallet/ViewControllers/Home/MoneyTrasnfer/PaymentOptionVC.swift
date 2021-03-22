//
//  PaymentOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class PaymentOptionVC: BaseVC  , PinVerifiedProtocol , CardSumitProtocol , BankDetailAlertProtocol
                       , AlertViewWithTextProtocol {
  
    var lockWallet:Bool = false
    let moneyRepo:MoneyTransferRepository = MoneyTransferRepository()
    let repo:Repository = Repository()
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
   // @IBOutlet weak var bankTitlelbl: UILabel!
   // @IBOutlet weak var bankAccountlbl: UILabel!
    
    var cardsList:[CardDetails] = Array()
    
    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
   // @IBOutlet weak var viewBankAccount: UIView!
    
    @IBOutlet weak var walletNameLbl:UILabel!
    @IBOutlet weak var walletBalancelbl:UILabel!
   // @IBOutlet weak var payThroughCard:UILabel!
    
    
    @IBOutlet weak var payThroughWalletBtn: UIButton!
    @IBOutlet weak var payThroughCardBtn: UIButton!
    @IBOutlet weak var payThroughBankBtn: UIButton!
    @IBOutlet weak var transferNowBtn: UIButton!
    
    @IBOutlet private var optionBtns:[UIButton]! {
        didSet {
            optionBtns.forEach { (button) in
                button.setImage(#imageLiteral(resourceName: "radioUnchecked"), for: .normal)
                button.setImage(#imageLiteral(resourceName: "radioChecked"), for: .selected)
            }
        }
    }
    
    
    var receiptNumber:String = ""
    var isTableViewVisiable = false
    var selectedTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        payThroughWalletBtn.isSelected = true
        toolTitle.text = "payment".localized
        pageTitle.text = "how_would_you_like".localized
        payThroughCardBtn.setTitle("pay_thorough_card".localized, for: .normal)
        payThroughBankBtn.setTitle("pay_thorough_bank".localized, for: .normal)
        payThroughWalletBtn.setTitle("pay_thorough_wallet".localized, for: .normal)
        transferNowBtn.setTitle("transfer_now".localized, for: .normal)
        btnLoad.setTitle("load_cards".localized, for: .normal)
       
        transferNowBtn.layer.cornerRadius = 8
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        viewWallet.layer.cornerRadius = 8
        btnLoad.layer.cornerRadius = 8
        cardTableView.layer.cornerRadius = 8
      
        getWalletDetails()

    }
    
    
    @IBAction private func paymentAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        selectedTag = sender.tag
    }
    
    func uncheck(){
        optionBtns.forEach { (button) in
            button.isSelected = false
        }
    }

    
    @IBAction func transferNowBtnClick(_ sender: Any) {
        if selectedTag == payThroughWalletBtn.tag {
            if !lockWallet  {
                TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.WALLET
                TotiPaySend.shared.cardNumber = ""
                TotiPaySend.shared.expireDate = ""
                TotiPaySend.shared.securityNumber = ""
                getPin()
            } else {
                showError(message: "Sending Currency is not registered with wallet")
            }
        } else if selectedTag == payThroughCardBtn.tag {
            let nextVC = ControllerID.cardDetailVC.instance
            (nextVC as! CardDetailVC).delegate = self
            self.pushWithFullScreen(nextVC)
        } else if selectedTag == payThroughBankBtn.tag {
            TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.BANK_DEPOSIT
            TotiPaySend.shared.cardNumber = ""
            TotiPaySend.shared.expireDate = ""
            TotiPaySend.shared.securityNumber = ""
            getPin()
        } else {
            
        }
    }
    

    
    @IBAction func btnLoadFunc(_ sender: UIButton) {
       getCustomerCards()
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
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
        TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.CREDIT_CARD
        TotiPaySend.shared.cardNumber = cardNumber
        TotiPaySend.shared.expireDate = cardExpire
        TotiPaySend.shared.securityNumber = cardCVV
        getPin()
    }
    
    
    func handleAction(txtFieldValue: String) {
        TotiPaySend.shared.securityNumber = txtFieldValue
        getPin()
    }
    

    func loadWallet() {
        if preferenceHelper.getISKYCApproved() {
            if Network.isConnectedToNetwork() {
                self.showProgress()
                print(TotiPaySend.shared.getXML())
                moneyRepo.sendTotiPay(request: HTTPConnection.openConnection(stringParams: TotiPaySend.shared.getXML(), action: SoapActionHelper.shared.ACTION_SEND_TRANSFER), completion: {(response , error)  in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        preferenceHelper.isWalletNeedToUpdate(isNeed: true)
                        self.receiptNumber = response!.transactionNo!
                        if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.CREDIT_CARD {
                            AlertView.instance.delegate = self
                            AlertView.instance.showAlert(title: "in_process".localized , message: "in_process_msg_card".localized , hide: true)
            
                        } else if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.BANK_DEPOSIT {
                            let nextVc = ControllerID.bankDepositDetail.instance
                            (nextVc as! DepositBankDetailsVC).receiptNumber = response!.transactionNo!
                            //(nextVc as! ReceiptVC).comeFromHome = false
                            self.pushWithFullScreen(nextVc)
                        } else if TotiPaySend.shared.paymentTypeId == PaymentTypes.shared.WALLET {
                            self.goToReceipt(number: response!.transactionNo!)
                        }
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            }
        } else {
            showError(message: "plz_complete_kyc".localized)
        }
    }
    
    
    override func handleAction(action: Bool) {
        goToReceipt(number: receiptNumber)
    }
    
    
    func handleAction() {
        goToReceipt(number: receiptNumber)
    }
    
    
    func goToReceipt(number:String) {
        let nextVc = ControllerID.receiptVC.instance
        (nextVc as! ReceiptVC).tranactionNumber = receiptNumber
        (nextVc as! ReceiptVC).comeFromHome = false
        self.pushWithFullScreen(nextVc)
    }
    
    
    func getCustomerCards() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let request = GetCardDetailsRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getApiLangugae()
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
        TotiPaySend.shared.paymentTypeId = PaymentTypes.shared.CREDIT_CARD
        TotiPaySend.shared.cardNumber = cardsList[indexPath.row].cardNumber
        TotiPaySend.shared.expireDate = cardsList[indexPath.row].cardExpireDate
        AlertViewWithTextField.instance.delegate = self
        AlertViewWithTextField.instance.showAlert(title: "enter_cvv".localized, txtFieldPlaceHolder: "cvv_txt".localized)
    }
    
    

    
    func getWalletDetails() {
        if Network.isConnectedToNetwork() {
            let request = WalletBalanceRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageId = preferenceHelper.getApiLangugae()
            request.walletCurrency = TotiPaySend.shared.payInCurrency
            
            showProgress()
            moneyRepo.getWalletBalance(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_WALLET_BALANCE), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.walletNameLbl.text = "Wallet \(TotiPaySend.shared.payInCurrency)"
                    self.walletBalancelbl.text = response!.walletBalance
                } else if response!.responseCode == 525 {
                    self.lockWallet = true
                } else {
                    self.showError(message: response!.description)
                }
            })
            
        } else {
            self.noInternet()
        }
    }

}
