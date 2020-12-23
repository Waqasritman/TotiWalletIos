//
//  AddMoneyVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddMoneyVC: BaseVC {

    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var btnProcced: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var pageTitlelbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnProcced.layer.cornerRadius = 8
        walletLbl.text = LoadWalletRequest.shared.walletCurrency
        pageTitlelbl.text = "enter_your_amount_you_want_to_load".localized
        btnProcced.setTitle("proceed_to_pay".localized, for: .normal)
    }
    
    
    override func isValidate() -> Bool {
        if txtAmount.text!.isEmpty {
            showError(message: "enter_the_amount".localized)
            return false
        }
        return true
    }
    
    @IBAction func btnProccedFunc(_ sender: UIButton) {
        if isValidate() {
            LoadWalletRequest.shared.transferAmount = txtAmount.text!
            let nextVC = ControllerID.addMoneyPaymentOptionVC.instance
            self.pushWithFullScreen(nextVC)
        }

    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }

}
