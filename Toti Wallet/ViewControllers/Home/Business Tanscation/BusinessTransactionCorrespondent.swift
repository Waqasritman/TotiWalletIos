//
//  BusinessTransactionCorrespondent.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTransactionCorrespondent: BaseVC {

    let repo:Repository = Repository()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSwift: UITextField!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        } else if txtSwift.text!.isEmpty {
            return false
        } else if txtAccount.text!.isEmpty {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.setLeftPaddingPoints(10)
        txtSwift.setLeftPaddingPoints(10)
        txtAccount.setLeftPaddingPoints(10)
        
        txtName.layer.cornerRadius = 8
        txtSwift.layer.cornerRadius = 8
        txtAccount.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
    }
    
    
    @IBAction func btnDone(_ sender:Any) {
        if isValidate(){
            B2BTransferDetails.shared.correspondentBank = txtName.text!
            B2BTransferDetails.shared.cbSwiftBIC = txtSwift.text!
            B2BTransferDetails.shared.cbAccountNumber = txtAccount.text!
            B2BTransferDetails.shared.customerNo = preferenceHelper.getCustomerNo()
            B2BTransferDetails.shared.languageId = preferenceHelper.getApiLangugae()
            
            showProgress()
            repo.b2bTransfer(request: HTTPConnection.openConnection(stringParams: B2BTransferDetails.shared.getXML(), action: SoapActionHelper.shared.ACTION_B2B_BENEFICIARY), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showSuccess(message: response!.description!)
                    self.closeBtnAction(self)
                } else {
                    self.showError(message: response!.description!)
                }
                
            })
        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.gotoHome()
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
