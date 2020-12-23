//
//  SummaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SummaryVC: BaseVC {
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var viewTransfer: UIView!
    @IBOutlet weak var viewSendingCurrencey: UIView!
    @IBOutlet weak var viewPayable: UIView!
    @IBOutlet weak var viewAmount: UIView!
    
    @IBOutlet weak var sendingcurrencylbl: UILabel!
    @IBOutlet weak var totalpayablelbl: UILabel!
    @IBOutlet weak var transferamountlbl: UILabel!
    
    @IBOutlet weak var transfertolbl: UILabel!
    @IBOutlet weak var beneNamelbl:UILabel!
    @IBOutlet weak var sendingCurrenyLbl:UILabel!
    @IBOutlet weak var totalPayableLbl:UILabel!
    @IBOutlet weak var transferAmountLbl:UILabel!
    
    
    var totalPayable:String!
    var beneName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageTitle.text = "confirm_title_money".localized
        transfertolbl.text = "sending_currency".localized
        sendingcurrencylbl.text = "sending_currency".localized
        totalpayablelbl.text = "total_payable".localized
        transferamountlbl.text = "transfer_amount".localized
        btnSendNow.setTitle("confirm_text".localized, for: .normal)
        
        
        btnSendNow.layer.cornerRadius = 8
        viewTransfer.layer.cornerRadius = 8
        viewSendingCurrencey.layer.cornerRadius = 8
        viewPayable.layer.cornerRadius = 8
        viewAmount.layer.cornerRadius = 8
        
        beneNamelbl.text = beneName
        sendingCurrenyLbl.text = TotiPaySend.shared.payInCurrency
        totalPayableLbl.text = totalPayable + " " + TotiPaySend.shared.payInCurrency
        transferAmountLbl.text = TotiPaySend.shared.transferAmount + " " + TotiPaySend.shared.payOutCurrency
        
        
    }
    
    @IBAction func btnShowFunc(_ sender: UIButton) {
        let nextVC = ControllerID.paymentOptionVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}


