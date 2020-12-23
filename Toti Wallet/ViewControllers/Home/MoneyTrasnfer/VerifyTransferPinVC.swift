//
//  VerifyTransferPinVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class VerifyTransferPinVC: BaseVC {

    @IBOutlet weak var btnConfirm: UIButton!
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewVerificationCode: KWVerificationCodeView!
    var delegate:PinVerifiedProtocol!
    
    @IBOutlet weak var pageTitle: UILabel!
    
    override func isValidate() -> Bool {
        if viewVerificationCode.getVerificationCode().count < 4 {
            showError(message: "askfordigit".localizedLowercase)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConfirm.layer.cornerRadius = 8
        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewVerificationCode.textFieldViews.forEach({ (KWTextFieldView) in
            KWTextFieldView.clipsToBounds = true
            KWTextFieldView.layer.cornerRadius = 8
        })
        
        
        pageTitle.text = "enter_pin_tosend".localized
        btnConfirm.setTitle("confirm_text".localized, for: .normal)
    }
    
    
    @IBAction func btnEdit(_ sender:Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func btnConfirm(_ sender:Any) {
        if Network.isConnectedToNetwork() {
            if isValidate() {
                let request = MatchPinRequest()
                request.customerNO = preferenceHelper.getCustomerNo()
                request.languageID = preferenceHelper.getLanguage()
                request.customerPIN = viewVerificationCode.getVerificationCode()
                showProgress()
                authRepo.matchPin(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_MATCH_PIN), completion: {(response, error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response?.responseCode == 101 {
                        self.delegate.onPinVerified(action: true)
                        self.btnBackFunc(self)
                    } else {
                        self.showError(message: response!.description)
                    }
                })
            }
        } else {
            self.noInternet()
        }
    }
    
    
    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
