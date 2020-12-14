//
//  SummaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SummaryVC: UIViewController {

    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var viewTransfer: UIView!
    @IBOutlet weak var viewSendingCurrencey: UIView!
    @IBOutlet weak var viewPayable: UIView!
    @IBOutlet weak var viewAmount: UIView!
    
    
    @IBOutlet weak var beneNamelbl:UILabel!
    @IBOutlet weak var sendingCurrenyLbl:UILabel!
    @IBOutlet weak var totalPayableLbl:UILabel!
    @IBOutlet weak var transferAmountLbl:UILabel!
    
    
    var totalPayable:String!
    var beneName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}


