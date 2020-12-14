//
//  AddMoneyVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddMoneyVC: BaseVC {

    @IBOutlet weak var btnProcced: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnProcced.layer.cornerRadius = 8
    }
    
    
    override func isValidate() -> Bool {
        if txtAmount.text!.isEmpty {
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
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }

}
