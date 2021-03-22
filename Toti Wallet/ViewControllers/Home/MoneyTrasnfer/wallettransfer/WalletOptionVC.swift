//
//  WalletOptionVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/5/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import UIKit

class WalletOptionVC: BaseVC {
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var viewBottomSheet: UIView!
    @IBOutlet weak var viewSheet: UIView!
    @IBOutlet weak var btnSendMoney: UIButton!
    @IBOutlet weak var btnRequestMoney: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBottomSheet.layer.cornerRadius = 16
        viewBottomSheet.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnSendMoney.layer.cornerRadius = 8
        btnRequestMoney.layer.cornerRadius = 8
      
        
        btnSendMoney.setTitle("send_money_txt".localized, for: .normal)
        btnRequestMoney.setTitle("request_money_btn".localized, for: .normal)
    }
    
    
    @IBAction func btnSendMoneyFunc(_ sender: UIButton) {
        let nextVC = ControllerID.walletTransferVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnRequestMoney(_ sender: UIButton) {
        let nextVC = ControllerID.requestMoneyVC.instance
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
