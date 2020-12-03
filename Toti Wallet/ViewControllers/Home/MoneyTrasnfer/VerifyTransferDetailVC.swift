//
//  VerifyTransferDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class VerifyTransferDetailVC: BaseVC {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
        
        txtSendingCurrency.text = walletRequest.payInCurrency
        
    }
    
    @IBAction func btnConfirmFunc(_ sender: UIButton) {
        protocolConfirm.onConfirmSummary()
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
