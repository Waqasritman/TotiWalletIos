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
    
    @IBOutlet weak var pageSubititle: UILabel!
    @IBOutlet weak var didnotreBtn: UIButton!
    
    var authRequest = AuthenticationRequest()
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
        if viewVerificationCode.getVerificationCode().trim().count < 4 {
            showError(message: "askfordigit".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.setTitle("resend_otp".localized, for: .normal)
        pageSubititle.text = "verify_otp_txt".localized
        didnotreBtn.setTitle("did_not_receive_otp".localized, for: .normal)
        btnConfirm.setTitle("confirm_text".localized, for: .normal)
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
                
                if verifyOTPRequest.OTP.count < 4 {
                    showError(message: "askfordigit".localized)
                    return
                }
                
                if isByNumber {
                    verifyOTPRequest.email = ""
                    verifyOTPRequest.mobileNumber = RegisterUserRequest.shared.phoneNumber
                } else {
                    verifyOTPRequest.email = RegisterUserRequest.shared.email
                    verifyOTPRequest.mobileNumber = ""
                }
                verifyOTPRequest.languageID = preferenceHelper.getApiLangugae()
                
                authRepository.verifyOTP(request: HTTPConnection.openConnection(stringParams: verifyOTPRequest.getXML(), action: SoapActionHelper.shared.ACTION_VERIFY_OTP), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else {
                        self.showAlert(title: "attention_txt".localized, message: "otp_message".localized 
                                       + " " + verifyOTPRequest.OTP + " " + "remember_me_otp".localized , hidebtn: true)
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
    
    
    @IBAction func btnResend(_ sender:Any) {
        reSendOTP()
    }
    
    
    
    func reSendOTP() {
        authRepository.authRequest(request: HTTPConnection.openConnection(stringParams: authRequest.getXML(), action: SoapActionHelper.shared.ACTION_AUTHENTICATION),completion: { (response, error) in
            self.hideProgress()
            if let error = error {
                self.showError(message: error)
            } else if response?.responseCode == 101 {
                self.showSuccess(message: response!.description!)
                self.startTimer()
            }
        })
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
            timerLabel.setTitle("\("resend_otp".localized) in 00:\(counter)", for: .normal)
            timerLabel.isEnabled = false
            counter -= 1
        } else {
            timerLabel.setTitle("resend_otp".localized, for: .normal)
            timerLabel.isEnabled = true
        }
    }
    
}
