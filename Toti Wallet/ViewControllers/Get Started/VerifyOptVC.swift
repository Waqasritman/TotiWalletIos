//
//  VerifyOptVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class VerifyOptVC: UIViewController {
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewVerificationCode: KWVerificationCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnConfirm.layer.cornerRadius = 8
        
        viewVerificationCode.textFieldViews.forEach({ (KWTextFieldView) in
            KWTextFieldView.clipsToBounds = true
            KWTextFieldView.layer.cornerRadius = 8
        })
        
    }
    
    @IBAction func btnConfimFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "Important !", message: "Your Totipay Wallet password is 1670 Please use this OPT as login PIN in future.")
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension VerifyOptVC: PopUpProtocol {
    
    func handleAction(action: Bool) {
        let nextVC = ControllerID.profileBasicDetailVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
}
