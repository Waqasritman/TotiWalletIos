//
//  AddCreditCardVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 14/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddCreditCardVC: BaseVC, UITextFieldDelegate {
    
    let repo:Repository = Repository()
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtExpireDat: UITextField!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        } else if txtNumber.text!.isEmpty {
            return false
        } else if txtExpireDat.text!.isEmpty {
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCard.layer.cornerRadius = 12
        txtName.layer.cornerRadius = 12
        txtNumber.layer.cornerRadius = 12
        txtExpireDat.layer.cornerRadius = 12
  
        
        txtName.setLeftPaddingPoints(10)
        txtNumber.setLeftPaddingPoints(10)
        txtExpireDat.setLeftPaddingPoints(10)
        
        btnSubmit.layer.cornerRadius = 8
        
        txtName.delegate = self
        txtNumber.delegate = self
        txtExpireDat.delegate = self
        
    }
    
    
    
    @IBAction func addCardDetails(_ sender:Any) {
        if Network.isConnectedToNetwork() {
            if isValidate() {
                showProgress()
                let request = SaveCardDetailsRequest()
                request.customerNo = preferenceHelper.getCustomerNo()
                request.customerCardNo = txtNumber.text!
                request.cardName = txtName.text!
                request.cardExpireDate = txtExpireDat.text!
                
                
                repo.saveCardDetails(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_SAVE_CARD_DETAILS), completion: {(response , error ) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                        self.btnBackFunc(self)
                    } else {
                        self.showError(message: response!.description!)
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

extension AddCreditCardVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString = string
        let txtFieldText = textField.text!
        var finalString = ""
        print(textField.tag)
        if string.count > 0 { // if it was not delete character
            finalString = txtFieldText + currentString
        }
        else if txtFieldText.count > 0 { // if it was a delete character
            finalString = String(txtFieldText.dropLast())
        }
        
        if textField.tag == 1 {
            lblName.text = finalString
        }
        else if textField.tag == 2 {
            lblNumber.text = finalString
        }
        else {
            lblExpireDate.text = finalString
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            lblName.text = ""
        }
        else if textField.tag == 2 {
            lblNumber.text = ""
        }
        else{
            lblExpireDate.text = ""
        }
        return true
    }
    
}