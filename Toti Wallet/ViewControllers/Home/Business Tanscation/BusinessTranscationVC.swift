//
//  BusinessTranscationVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 01/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTranscationVC: BaseVC {

    @IBOutlet weak var txtBeneficiaryName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func isValidate() -> Bool {
        if txtBeneficiaryName.text!.isEmpty {
            return false
        } else if txtAddress.text!.isEmpty {
            return false
        } else if txtContactNumber.text!.isEmpty {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        txtBeneficiaryName.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        txtContactNumber.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtBeneficiaryName.setLeftPaddingPoints(10)
        txtAddress.setLeftPaddingPoints(10)
        txtContactNumber.setLeftPaddingPoints(10)
        
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        
        if isValidate() {
            B2BTransferDetails.shared.beneName = txtBeneficiaryName.text!
            B2BTransferDetails.shared.beneAddress = txtAddress.text!
            B2BTransferDetails.shared.beneContactNo = txtContactNumber.text!
            
            let nextVC = ControllerID.businessTransactionPaymentDetail.instance
            self.pushWithFullScreen(nextVC)
        }
        
 
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func closeBtnAction(_ sender: Any) {
    }
    
}
