//
//  AddCreditCardVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 14/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddCreditCardVC: UIViewController {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtExpireDat: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCard.layer.cornerRadius = 12
        txtName.layer.cornerRadius = 12
        txtNumber.layer.cornerRadius = 12
        txtExpireDat.layer.cornerRadius = 12
        
        txtName.setLeftPaddingPoints(10)
        txtNumber.setLeftPaddingPoints(10)
        txtExpireDat.setLeftPaddingPoints(10)
        
        btnSubmit.layer.cornerRadius = 8
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
