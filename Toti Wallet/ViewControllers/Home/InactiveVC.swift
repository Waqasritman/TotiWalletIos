//
//  InactiveVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class InactiveVC: UIViewController {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.layer.cornerRadius = 8
        btnClose.layer.cornerRadius = 8
        
        btnClose.layer.borderWidth = 1
        btnClose.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        
        
        pageTitle.text = "talfie_locked".localized
        pageMessage.text = "toti_logout_auto_text".localized
        
        btnLogin.setTitle("login_text".localized, for: .normal)
        btnClose.setTitle("close_text".localized, for: .normal)
    }
    
    
    
    @IBAction func onRelogin(_ sender:Any) {
        let nextVC = ControllerID.loginSignUpOptionVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func onClose(_ sender:Any) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
