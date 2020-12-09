//
//  ForgotPassGetPinVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassGetPinVC: BaseVC {

    let authRepository :AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnChangePin: UIButton!

    @IBOutlet weak var txtNewPin: UITextField!
    @IBOutlet weak var txtReEnterNewPin: UITextField!
    
    
    var isByNumber = false
    
    override func isValidate() -> Bool {
        if txtNewPin.text!.isEmpty {
            return false
        } else if txtReEnterNewPin.text!.isEmpty {
            return false
        } else if txtNewPin.text!.count < 4 {
            return false
        } else if txtReEnterNewPin.text!.count < 4 {
            return false
        } else if !txtNewPin.text!.elementsEqual(txtReEnterNewPin.text!) {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        
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
                request.languageId = preferenceHelper.getLanguage()
                
                authRepository.resetPinForgot(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_SET_NEW_PIN), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                       
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                        ForgotPinRequestApprovedUserRequest.shared.clearData()
                       // let nextVC = ControllerID.getStartedNav.instance
                       // self.pushWithFullScreen(nextVC)
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
    

}
