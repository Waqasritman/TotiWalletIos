//
//  BusinessTransctionBankDetail.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTransctionBankDetail: BaseVC {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtBranch: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtSwift: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        } else if txtAccountNumber.text!.isEmpty {
            return false
        } else if txtBranch.text!.isEmpty {
            return false
        } else if txtAddress.text!.isEmpty {
            return false
        } else if txtSwift.text!.isEmpty {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.layer.cornerRadius = 8
        txtAccountNumber.layer.cornerRadius = 8
        txtBranch.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        txtSwift.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtName.setLeftPaddingPoints(10)
        txtAccountNumber.setLeftPaddingPoints(10)
        txtBranch.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        txtSwift.setLeftPaddingPoints(10)
        
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        if isValidate() {
            B2BTransferDetails.shared.bankName = txtName.text!
            B2BTransferDetails.shared.accountNumber = txtAccountNumber.text!
            B2BTransferDetails.shared.bankBranch = txtBranch.text!
            B2BTransferDetails.shared.bankAddress = txtAddress.text!
            B2BTransferDetails.shared.swiftBIC = txtSwift.text!
            
            let nextVC = ControllerID.businessTransactionCorrespondent.instance
            self.pushWithFullScreen(nextVC)
        }
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func closeBtnAction(_ sender: Any) {
    }
}
