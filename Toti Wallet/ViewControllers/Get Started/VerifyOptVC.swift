//
//  VerifyOptVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class VerifyOptVC: BaseVC {
    
    let authRepository:AuthRepository = AuthRepository()
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewVerificationCode: KWVerificationCodeView!
    @IBOutlet weak var timerLabel:UIButton!
    
    var isByNumber:Bool = true
    
    /**
     timer counter
     */
    var counter = 59
    /**
     timervariable
     */
    var timerTest: Timer? = nil
    
    
    
    override func isValidate() -> Bool {
        if viewVerificationCode.getVerificationCode().count < 4 {
            showError(message: "Enter correct pin")
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnConfirm.layer.cornerRadius = 8
        
        viewVerificationCode.textFieldViews.forEach({ (KWTextFieldView) in
            KWTextFieldView.clipsToBounds = true
            KWTextFieldView.layer.cornerRadius = 8
        })
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /**
         stop the timer on viewdisppaer
         */
        stopTimer()
    }
    
    @IBAction func btnConfimFunc(_ sender: UIButton) {
        
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                let verifyOTPRequest = VerifyOTPRequest()
                verifyOTPRequest.OTP = viewVerificationCode.getVerificationCode()
                
                if isByNumber {
                    verifyOTPRequest.email = ""
                    verifyOTPRequest.mobileNumber = RegisterUserRequest.shared.phoneNumber
                } else {
                    verifyOTPRequest.email = RegisterUserRequest.shared.email
                    verifyOTPRequest.mobileNumber = ""
                }
                verifyOTPRequest.languageID = "1"
                
                authRepository.verifyOTP(request: HTTPConnection.openConnection(stringParams: verifyOTPRequest.getXML(), action: SoapActionHelper.shared.ACTION_VERIFY_OTP), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                        self.showAlert(title: "Important!", message: "Your Totipay Wallet password is \(verifyOTPRequest.OTP)  Please use this OTP as login PIN in future.")
                    }
                })
                
                
                
            } else {
                self.noInternet()
            }
        }
        
        
        
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func handleAction(action: Bool) {
        let nextVC = ControllerID.profileBasicDetailVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    
    func startTimer() {
        guard timerTest == nil else { return }
        timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timerTest?.invalidate()
        timerTest = nil
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            timerLabel.setTitle("resend in 00:\(counter)", for: .normal)
            timerLabel.isEnabled = false
            counter -= 1
        } else {
            timerLabel.setTitle("Resend", for: .normal)
            timerLabel.isEnabled = true
        }
    }
    
}
