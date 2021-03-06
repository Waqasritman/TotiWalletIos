//
//  LoginSignUpOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class LoginSignUpOptionVC: BaseVC {

    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnExistingCustomer: UIButton!
    @IBOutlet weak var dropDown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCreateAccount.layer.cornerRadius = 8
        btnExistingCustomer.layer.cornerRadius = 8
        
        dropDown.optionArray = ["English","Arabic"]
        dropDown.didSelect{(selectedText , index ,id) in
           print("Selected String: \(selectedText) \n index: \(index)")
        }
    }
    
    @IBAction func btnCreateAccountFunc(_ sender: UIButton) {
        let nextVC = ControllerID.signUpVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnEsitingCustomerFunc(_ sender: UIButton) {
        let nextVC = ControllerID.loginOptionVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
}
