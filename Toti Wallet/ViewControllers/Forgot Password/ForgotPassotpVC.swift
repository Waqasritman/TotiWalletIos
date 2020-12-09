//
//  ForgotPassotpVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/30/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ForgotPassotpVC: BaseVC {
    
    
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
       // startTimer()
        sendOTP()
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
    
    
    func sendOTP() {
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = ForgotPinRequestApprovedUserRequest.shared.getXML()
            print(request)
            authRepository.forgotPinApprovedUserRequest(request: HTTPConnection.openConnection(stringParams: request, action: SoapActionHelper.shared.ACTION_FORGOT_REQUEST_APPROVED_USER), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    print("error")
                    self.showError(message: error)
                    self.btnBackFunc(self)
                } else {
                    print(response?.responseCode)
                    if response!.responseCode == 101 {
                        print("sendt")
                        self.startTimer()
                    } else {
                        self.showError(message: response!.description!)
                        self.btnBackFunc(self)
                    }
                }
            })
            
        } else {
            self.noInternet()
            self.btnBackFunc(self)
        }
    }
    
    @IBAction func btnConfimFunc(_ sender: UIButton) {
        
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                let verifyOTPRequest = VerifyOTPRequest()
                verifyOTPRequest.OTP = viewVerificationCode.getVerificationCode()
                
                if isByNumber {
                    verifyOTPRequest.email = ""
                    verifyOTPRequest.mobileNumber = ForgotPinRequestApprovedUserRequest.shared.mobileNumber
                } else {
                    verifyOTPRequest.email = ForgotPinRequestApprovedUserRequest.shared.emailAddress
                    verifyOTPRequest.mobileNumber = ""
                }
                verifyOTPRequest.languageID = "1"
                
                authRepository.verifyOTP(request: HTTPConnection.openConnection(stringParams: verifyOTPRequest.getXML(), action: SoapActionHelper.shared.ACTION_VERIFY_OTP), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                        let nextVC = ControllerID.forgotPassGetPinVC.instance
                        self.pushWithFullScreen(nextVC)
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
    
    
    
    override func handleAction(action: Bool) {
        let nextVC = ControllerID.forgotPassGetPinVC.instance
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
