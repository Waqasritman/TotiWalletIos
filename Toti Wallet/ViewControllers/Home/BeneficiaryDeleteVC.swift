//
//  BeneficiaryDeleteVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BeneficiaryDeleteVC: UIViewController {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnDelete.layer.cornerRadius = 8
        txtName.layer.cornerRadius = 8
        txtBankName.layer.cornerRadius = 8
        txtBranchName.layer.cornerRadius = 8
        txtAccountNumber.layer.cornerRadius = 8
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
