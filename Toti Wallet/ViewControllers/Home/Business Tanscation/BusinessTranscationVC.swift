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
    

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var contacttitle: UILabel!
    
    
    override func isValidate() -> Bool {
        if txtBeneficiaryName.text!.isEmpty {
            showError(message: "enter_name_bene_error".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        toolTitle.text = "swift_transfer".localized
        pageTitle.text = "enter_bene_personal_details".localized
        nameTitle.text = "beneficiary_name_account_title".localized
        addressTitle.text = "address_txt".localized
        contacttitle.text = "contact_no".localized
        
        txtBeneficiaryName.placeholder = "jhon_smith".localized
        txtAddress.placeholder = "address__hint".localized
        txtContactNumber.placeholder = "phone_number_hint".localized
        btnNext.setTitle("next".localized, for: .normal)
        
    
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
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
}
