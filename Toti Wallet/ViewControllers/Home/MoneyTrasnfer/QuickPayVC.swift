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
    @IBOutlet weak var viewBottomSheet: UIView!
    @IBOutlet weak var viewSheet: UIView!
    @IBOutlet weak var btnSendMoney: UIButton!
    @IBOutlet weak var btnRequestMoney: UIButton!
    
    var isBottomSheetVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWallet.layer.cornerRadius = 8
        viewBank.layer.cornerRadius = 8
        viewCash.layer.cornerRadius = 8
        
        viewBottomSheet.layer.cornerRadius = 16
        viewBottomSheet.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnSendMoney.layer.cornerRadius = 8
        btnRequestMoney.layer.cornerRadius = 8
        
        
        let viewWalletGesture = UITapGestureRecognizer(target: self, action: #selector(viewWalletFunc(_:)))
        viewWallet.addGestureRecognizer(viewWalletGesture)
        
        let viewBankGesture = UITapGestureRecognizer(target: self, action: #selector(viewBankFunc(_:)))
        viewBank.addGestureRecognizer(viewBankGesture)
        
        let viewCashGesture = UITapGestureRecognizer(target: self, action: #selector(viewCashFunc(_:)))
        viewCash.addGestureRecognizer(viewCashGesture)
    }
    
    @objc func viewWalletFunc(_ sender: UITapGestureRecognizer) {
        self.isBottomSheetVisible = true
        self.viewSheet.isHidden = false
    }
    
    @objc func viewBankFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.beneficiaryListVC.instance
        (nextVC as! BeneficiaryListVC).isFromBankTransfer = true
        self.pushWithFullScreen(nextVC)
    }
    
    @objc func viewCashFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.beneficiaryListVC.instance
        (nextVC as! BeneficiaryListVC).isFromCashTransfer = true
        self.pushWithFullScreen(nextVC)
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
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        if isBottomSheetVisible {
            self.isBottomSheetVisible = false
            self.viewSheet.isHidden = true
        }
        else{
            if let check = tabBarController as? CustomTabBarController {
                check.selectedIndex = 0
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
  

}
