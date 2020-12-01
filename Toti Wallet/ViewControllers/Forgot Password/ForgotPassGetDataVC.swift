//
//  ForgotPassGetDataVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetDataVC: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var txtExpireDate: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        txtIDNumber.layer.cornerRadius = 8
        txtExpireDate.layer.cornerRadius = 8
        txtExpireDate.setLeftPaddingPoints(5)
        
        btnConfirm.layer.cornerRadius = 8
        
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
