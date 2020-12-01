//
//  BusinessTranscationVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 01/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTranscationVC: UIViewController {

    @IBOutlet weak var txtBeneficiaryName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtBeneficiaryName.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        txtContactNumber.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtBeneficiaryName.setLeftPaddingPoints(5)
        txtAddress.setLeftPaddingPoints(5)
        txtContactNumber.setLeftPaddingPoints(5)
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   

}
