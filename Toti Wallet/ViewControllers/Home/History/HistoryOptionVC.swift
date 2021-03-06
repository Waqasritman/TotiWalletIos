//
//  HistoryOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 29/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class HistoryOptionVC: UIViewController {

    @IBOutlet weak var viewTransction: UIButton!
    @IBOutlet weak var viewWallet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTransction.layer.cornerRadius = 8
        viewWallet.layer.cornerRadius = 8
        
        viewTransction.imageEdgeInsets.left = self.view.frame.width - 50
        viewWallet.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    @IBAction func btnTranscationHistoryFunc(_ sender: UIButton) {
        let nextVC = ControllerID.transactionHistoryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnWalletHistoryFunc(_ sender: UIButton) {
        let nextVC = ControllerID.walletHistoryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }
    

}
