//
//  ChangePinVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ChangePinVC: BaseVC {
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnChangePin: UIButton!
    @IBOutlet weak var txtOldPin: UITextField!
    @IBOutlet weak var txtNewPin: UITextField!
    @IBOutlet weak var txtReEnterNewPin: UITextField!
    
    
    override func isValidate() -> Bool {
        if txtOldPin.text!.isEmpty {
            showError(message: "enter_old_pin".localizedLowercase)
          return false
        } else if txtNewPin.text!.isEmpty {
            showError(message: "enter_new_pin".localizedLowercase)
          return false
        } else if txtReEnterNewPin.text!.isEmpty {
            showError(message: "enter_confirm_pin".localizedLowercase)
          return false
        } else if !txtNewPin.text!.elementsEqual(txtReEnterNewPin.text!) {
            showError(message: "pin_must_be_same".localizedLowercase)
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        txtOldPin.layer.cornerRadius = 8
        txtNewPin.layer.cornerRadius = 8
        txtReEnterNewPin.layer.cornerRadius = 8
        
        btnChangePin.layer.cornerRadius = 8
        
    }
    
    @IBAction func btnContinueFunc(_ sender: UIButton) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                let changePinRequest = ChangePinRequest()
                changePinRequest.customerNo = preferenceHelper.getCustomerNo()
                changePinRequest.newPin = txtNewPin.text!
                changePinRequest.oldPin = txtOldPin.text!
                changePinRequest.confirmPin = txtReEnterNewPin.text!
                changePinRequest.languageId = "1"
                print(changePinRequest.getXML())
                authRepo.changePin(request: HTTPConnection.openConnection(stringParams: changePinRequest.getXML(), action: SoapActionHelper.shared.ACTION_CHANGE_PIN), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                        if response?.responseCode == 101 {
                            self.showSuccess(message: (response?.description)!)
                            self.btnBackFunc(self)
                        } else {
                            self.showError(message: (response?.description)!)
                        }
                    }

                })
                
                
                

                
            }
        }
    }

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
