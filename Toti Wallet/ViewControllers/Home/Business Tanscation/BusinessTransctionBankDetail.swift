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
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var accountnolbl: UILabel!
    @IBOutlet weak var branchlbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    
    @IBOutlet weak var swiftbiclbl: UILabel!
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            showError(message: "select_bank_name".localized)
            return false
        } else if txtAccountNumber.text!.isEmpty {
            showError(message: "enter_account_no_error".localized)
            return false
        } else if txtBranch.text!.isEmpty {
            showError(message: "enter_bank_branch".localized)
            return false
        } else if txtAddress.text!.isEmpty {
            showError(message: "bankaddress_txt_error".localized)
            return false
        } else if txtSwift.text!.isEmpty {
            showError(message: "plz_enter_swift_ibc".localized)
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
        
        
        
        toolTitle.text = "swift_transfer".localized
        pageTitle.text = "enter_beneficiary_bank_details    ".localized
        namelbl.text = "bank_name".localized
        accountnolbl.text = "account_no_txt".localized
        branchlbl.text = "bank_branch_txt".localized
        addresslbl.text = "bankaddress_txt".localized
        swiftbiclbl.text = "swift_ibac".localized
        
        
        txtName.placeholder = "bank_name_txt".localized
        txtAccountNumber.placeholder = "account_no_hint".localized
        txtBranch.placeholder = "address__hint".localized
        txtAddress.placeholder = "address__hint".localized
        txtSwift.placeholder = "enter_swift_bic".localized
        
        
        btnNext.setTitle("next".localized, for: .normal)
        
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
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
}
