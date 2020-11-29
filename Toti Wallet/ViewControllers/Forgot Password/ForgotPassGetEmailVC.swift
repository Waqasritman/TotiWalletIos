//
//  ForgotPassGetEmailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetEmailVC: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnContinue.layer.cornerRadius = 8
    }
    

    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        //show countries here
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
