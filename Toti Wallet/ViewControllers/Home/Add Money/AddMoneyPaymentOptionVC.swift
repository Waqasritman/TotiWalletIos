//
//  AddMoneyPaymentOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddMoneyPaymentOptionVC: BaseVC , CardSumitProtocol , BankDetailAlertProtocol
                               , AlertViewWithTextProtocol {
    
   
    
    let repo:Repository = Repository()
    let moneyRepo:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var viewBankAccount: UIView!
    var cardsList:[CardDetails] = Array()
    var isTableViewVisiable = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        

        btnLoad.layer.cornerRadius = 8
        cardTableView.layer.cornerRadius = 8
        viewBankAccount.layer.cornerRadius = 8
        
        let viewBankAccountGesture = UITapGestureRecognizer(target: self, action: #selector(viewBankAccountFunc(_:)))
        viewBankAccount.addGestureRecognizer(viewBankAccountGesture)
    }
    
    @objc
    private func viewBankAccountFunc(_ sender: UIGestureRecognizer) {
        LoadWalletRequest.shared.paymentType = PaymentTypes.shared.BANK_DEPOSIT
        LoadWalletRequest.shared.cardNumber = ""
        LoadWalletRequest.shared.expireDate = ""
        LoadWalletRequest.shared.securityNumber = ""
        loadWallet()
    }
    
    @IBAction func btnLoadFunc(_ sender: UIButton) {
        getCustomerCards()
    }
    
    
    @IBAction func btnPaythroughCard(_ sender:UIButton) {
        let nextVC = ControllerID.cardDetailVC.instance
        (nextVC as! CardDetailVC).delegate = self
        self.pushWithFullScreen(nextVC)
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
    
    
    func onAddCardDetails(cardNumber: String, cardExpire: String, cardCVV: String) {
        LoadWalletRequest.shared.paymentType = PaymentTypes.shared.CREDIT_CARD
        LoadWalletRequest.shared.cardNumber = cardNumber
        LoadWalletRequest.shared.expireDate = cardExpire
        LoadWalletRequest.shared.securityNumber = cardCVV
        loadWallet()
    }
    
    
    func handleAction(txtFieldValue: String) {
        LoadWalletRequest.shared.securityNumber = txtFieldValue
        loadWallet()
    }
    
    
    func handleAction() {
        
    }
    

    func loadWallet() {
        if preferenceHelper.getISKYCApproved() {
            if Network.isConnectedToNetwork() {
                showProgress()
                LoadWalletRequest.shared.languageId = preferenceHelper.getLanguage()
                LoadWalletRequest.shared.customerNo = preferenceHelper.getCustomerNo()
                
                moneyRepo.loadWallet(request: HTTPConnection.openConnection(stringParams: LoadWalletRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_LOAD_WALLET), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        if LoadWalletRequest.shared.paymentType == PaymentTypes.shared.CREDIT_CARD {
                            AlertView.instance.delegate = self
                            AlertView.instance.showAlert(title: "in_process".localiz() , message: "in_process_msg_card".localiz())
            
                        } else if LoadWalletRequest.shared.paymentType == PaymentTypes.shared.BANK_DEPOSIT {
                            BankDetailAlert.instance.delegate = self
                            BankDetailAlert.instance.showAlert(referenceNumber: response!.referenceNo)
                        }
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
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

extension AddMoneyPaymentOptionVC: UITableViewDelegate, UITableViewDataSource {
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
        LoadWalletRequest.shared.paymentType = PaymentTypes.shared.CREDIT_CARD
        LoadWalletRequest.shared.cardNumber = cardsList[indexPath.row].cardNumber
        LoadWalletRequest.shared.expireDate = cardsList[indexPath.row].cardExpireDate
        AlertViewWithTextField.instance.delegate = self
        AlertViewWithTextField.instance.showAlert(title: "enter_cvv".localiz(), txtFieldPlaceHolder: "CVV")
    }
}
