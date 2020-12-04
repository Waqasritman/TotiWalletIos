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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSendNow.layer.cornerRadius = 8
        viewTransfer.layer.cornerRadius = 8
        viewSendingCurrencey.layer.cornerRadius = 8
        viewPayable.layer.cornerRadius = 8
        viewAmount.layer.cornerRadius = 8
        
    }
    
    @IBAction func btnShowFunc(_ sender: UIButton) {
        let nextVC = ControllerID.paymentOptionVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}


