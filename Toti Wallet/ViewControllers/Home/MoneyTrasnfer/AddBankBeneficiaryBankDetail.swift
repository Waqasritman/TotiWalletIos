//
//  AddBankBeneficiaryBankDetail.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddBankBeneficiaryBankDetail: UIViewController {

    @IBOutlet weak var btnBankName: UIButton!
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnBranchName: UIButton!
    @IBOutlet weak var btnAccountNumber: UITextField!
    @IBOutlet weak var btnReEnterAccount: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnBankName.layer.cornerRadius = 8
        txtCityName.layer.cornerRadius = 8
        txtLocation.layer.cornerRadius = 8
        btnBranchName.layer.cornerRadius = 8
        btnAccountNumber.layer.cornerRadius = 8
        btnReEnterAccount.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtCityName.setLeftPaddingPoints(10)
        txtLocation.setLeftPaddingPoints(10)
        btnAccountNumber.setLeftPaddingPoints(10)
        btnReEnterAccount.setLeftPaddingPoints(10)
        
        btnBankName.imageEdgeInsets.left = self.view.frame.width - 50
        btnBranchName.imageEdgeInsets.left = self.view.frame.width - 50
    }
    

    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
