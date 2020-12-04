//
//  CashBeneficaryAddressVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficaryAddressVC: UIViewController {

    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var btnAgent: UIButton!
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCity.layer.cornerRadius = 8
        btnAgent.layer.cornerRadius = 8
        btnAddBeneficiary.layer.cornerRadius = 8
        
        btnAgent.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}
