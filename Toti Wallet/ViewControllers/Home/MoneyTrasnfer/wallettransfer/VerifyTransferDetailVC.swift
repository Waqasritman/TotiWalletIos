//
//  VerifyTransferDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class VerifyTransferDetailVC: BaseVC {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var sendingCurrencylbl: UILabel!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var mobilelbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var decriptionLBL: UILabel!
    
    @IBOutlet weak var txtSendingCurrency: UITextField!
    @IBOutlet weak var txtReceivingCurrency: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtWalletName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var walletRequest:WalletToWalletTransferRequest!
    var protocolConfirm:OnConfirmSummaryProtocol!
    var walletName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        showSummary()
        disableViews()
        
        
        pageTitle.text = "wallet_to_wallet_summary".localized
        sendingCurrencylbl.text = "sending_currency".localized
        currencylbl.text = "receiving__currency_txt".localized
        mobilelbl.text = "mobile_number_txt".localized
        walletLbl.text = "wallet_name_txt".localized
        amountLbl.text = "amount_text_".localized
        decriptionLBL.text = "wallet_des_hint".localized
        
        
        
        txtSendingCurrency.setLeftPaddingPoints(10)
        txtReceivingCurrency.setLeftPaddingPoints(10)
        txtMobileNumber.setLeftPaddingPoints(10)
        txtWalletName.setLeftPaddingPoints(10)
        txtAmount.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        
        btnEdit.setTitle("edit".localized, for: .normal)
        btnConfirm.setTitle("confirm_text".localized, for: .normal)
    }
    
    
    func showSummary() {
        txtSendingCurrency.text = walletRequest.payInCurrency
        txtReceivingCurrency.text = walletRequest.receiptCurrency
        txtMobileNumber.text = walletRequest.receiptMobileNo
        txtWalletName.text = walletName
        txtDescription.text = walletRequest.description
        txtAmount.text = walletRequest.transferAmount
        
        
        if walletRequest.description.isEmpty {
            txtDescription.isHidden = true
            decriptionLBL.isHidden = true
        }
    }
    
    func disableViews() {
        txtSendingCurrency.isEnabled = false
        txtReceivingCurrency.isEnabled = false
        txtMobileNumber.isEnabled = false
        txtWalletName.isEnabled = false
        txtDescription.isEnabled = false
        txtAmount.isEnabled = false
    }
    
    
    func initDesign() {
        txtSendingCurrency.layer.cornerRadius = 8
        txtReceivingCurrency.layer.cornerRadius = 8
        txtMobileNumber.layer.cornerRadius = 8
        txtWalletName.layer.cornerRadius = 8
        txtAmount.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        btnEdit.layer.cornerRadius = 8
        btnConfirm.layer.cornerRadius = 8
        
        btnConfirm.layer.borderWidth = 1
        btnConfirm.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
    }
    
    @IBAction func btnConfirmFunc(_ sender: UIButton) {
        self.btnBackFunc(self)
        protocolConfirm.onConfirmSummary()
    }
    
    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
