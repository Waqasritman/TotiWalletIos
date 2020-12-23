//
//  ForgotPassGetPinVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetPinVC: BaseVC  , UITextFieldDelegate {

    let authRepository :AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnChangePin: UIButton!

    @IBOutlet weak var txtNewPin: UITextField!
    @IBOutlet weak var txtReEnterNewPin: UITextField!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var enterNewpinlbl: UILabel!
    
    @IBOutlet weak var reenterpinlbl: UILabel!
    var isByNumber = false
    
    override func isValidate() -> Bool {
        if txtNewPin.text!.isEmpty {
            showError(message: "enter_new_pin".localized)
            return false
        } else if txtReEnterNewPin.text!.isEmpty {
            showError(message: "enter_confirm_pin".localized)
            return false
        } else if txtNewPin.text!.count < 4 {
            showError(message: "pin_must_4_digit".localized)
            return false
        } else if txtReEnterNewPin.text!.count < 4 {
            showError(message: "pin_must_4_digit".localized)
            return false
        } else if !txtNewPin.text!.elementsEqual(txtReEnterNewPin.text!) {
            showError(message: "pin_must_be_same".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        
        
        pageTitle.text = "change_pin".localized
        enterNewpinlbl.text = "new_pin".localized
        reenterpinlbl.text = "confirm_pin".localized
        btnChangePin.setTitle("change_pin".localized, for: .normal)
        
        
        txtNewPin.setLeftPaddingPoints(10)
        txtReEnterNewPin.setLeftPaddingPoints(10)
        
        txtNewPin.delegate = self
        txtReEnterNewPin.delegate = self
        
        txtNewPin.placeholder = "0000"
        txtReEnterNewPin.placeholder = "0000"
    }
    
    @IBAction func btnContinueFunc(_ sender: UIButton) {
        if isValidate() {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = ForgotPinSetNewRequest()
                request.newPin = txtNewPin.text!
                request.confirmPin = txtNewPin.text!
                if isByNumber {
                    request.emailAddress = ""
                    request.mobileNumber = ForgotPinRequestApprovedUserRequest.shared.mobileNumber
                } else {
                    request.emailAddress = ForgotPinRequestApprovedUserRequest.shared.emailAddress
                    request.mobileNumber = ""
                }
                request.languageId = preferenceHelper.getApiLangugae()
                
                authRepository.resetPinForgot(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_SET_NEW_PIN), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                       
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                        ForgotPinRequestApprovedUserRequest.shared.clearData()
                        for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: LoginOptionVC.self) {
                                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
            
          
            
        }
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func initDesign() {
        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        txtNewPin.layer.cornerRadius = 8
        txtReEnterNewPin.layer.cornerRadius = 8
        
        btnChangePin.layer.cornerRadius = 8

        txtNewPin.setLeftPaddingPoints(5)
        txtReEnterNewPin.setLeftPaddingPoints(5)
    }
    

    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return textField.text!.count < 4 || string == ""
    }
}
