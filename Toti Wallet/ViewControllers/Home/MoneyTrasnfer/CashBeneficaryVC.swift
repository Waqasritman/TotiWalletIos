//
//  CashBeneficaryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficaryVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtlastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnRelation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.layer.cornerRadius = 8
        txtMiddleName.layer.cornerRadius = 8
        txtlastName.layer.cornerRadius = 8
        txtMobile.layer.cornerRadius = 8
        btnCountry.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        btnRelation.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtMiddleName.setLeftPaddingPoints(10)
        txtlastName.setLeftPaddingPoints(10)
        txtMobile.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnRelation.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
