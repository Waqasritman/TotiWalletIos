//
//  QuickPayVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class QuickPayVC: UIViewController {

    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var viewBank: UIView!
    @IBOutlet weak var viewCash: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWallet.layer.cornerRadius = 8
        viewBank.layer.cornerRadius = 8
        viewCash.layer.cornerRadius = 8
        
        let viewWalletGesture = UITapGestureRecognizer(target: self, action: #selector(viewWalletFunc(_:)))
        viewWallet.addGestureRecognizer(viewWalletGesture)
        
        let viewBankGesture = UITapGestureRecognizer(target: self, action: #selector(viewBankFunc(_:)))
        viewBank.addGestureRecognizer(viewBankGesture)
        
        let viewCashGesture = UITapGestureRecognizer(target: self, action: #selector(viewCashFunc(_:)))
        viewCash.addGestureRecognizer(viewCashGesture)
    }
    
    @objc func viewWalletFunc(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func viewBankFunc(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func viewCashFunc(_ sender: UITapGestureRecognizer) {
        
    }

    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }
  

}
