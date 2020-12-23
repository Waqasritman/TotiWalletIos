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
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var beneNamelbl: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var accountNumberlbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnDelete.layer.cornerRadius = 8
        txtName.layer.cornerRadius = 8
        txtBankName.layer.cornerRadius = 8
        txtBranchName.layer.cornerRadius = 8
        txtAccountNumber.layer.cornerRadius = 8
        
        
        pageTitle.text = "beneficiary_details_txt".localized
        beneNamelbl.text = "bene_name".localized
        bankName.text = "bank_name".localized
        branchName.text  = "branch_name".localized
        accountNumberlbl.text = "acount_number_m".localized
        btnDelete.setTitle("delete_beneficary".localized, for: .normal)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
