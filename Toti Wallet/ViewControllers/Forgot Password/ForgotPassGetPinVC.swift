//
//  ForgotPassGetPinVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetPinVC: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnChangePin: UIButton!
    @IBOutlet weak var txtOldPin: UITextField!
    @IBOutlet weak var txtNewPin: UITextField!
    @IBOutlet weak var txtReEnterNewPin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        txtOldPin.layer.cornerRadius = 8
        txtNewPin.layer.cornerRadius = 8
        txtReEnterNewPin.layer.cornerRadius = 8
        
        btnChangePin.layer.cornerRadius = 8
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
