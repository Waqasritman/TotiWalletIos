//
//  CardDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import FormTextField
class CardDetailVC: BaseVC  , UITextFieldDelegate{
    
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    let mask = "##/##"
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: FormTextField!
    @IBOutlet weak var txtValid: FormTextField!
    @IBOutlet weak var txtCvv: UITextField!
    
    
    var delegate:CardSumitProtocol!
    
    @IBOutlet weak var cvvlbl: UILabel!
    @IBOutlet weak var validlbl: UILabel!
    @IBOutlet weak var cardnumberlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            showError(message: "Enter Name".localized)
            return false
        } else if txtNumber.text!.isEmpty || txtNumber.text!.count < 19 {
            showError(message: "enter_valid_card_number".localized)
            return false
        } else if txtValid.text!.isEmpty || txtValid.text!.count < 5 {
            showError(message: "plz_enter_valid_expire_date".localized)
            return false
        } else if txtCvv.text!.isEmpty {
            showError(message: "plz_enter_valid_cvv".localized)
            return false
        } else if txtCvv.text!.count < 3 {
            showError(message: "plz_enter_valid_cvv".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        namelbl.text = "name_on_card_txt".localized
        cardnumberlbl.text = "number_on_card".localized
        validlbl.text = "valid_through".localized
        cvvlbl.text = "cvv_txt".localized
        btnSubmit.setTitle("submit_txt".localized, for: .normal)
        
        txtNumber.delegate = self
        txtValid.delegate = self
        txtCvv.delegate = self
        
        txtNumber.setLeftPaddingPoints(10)
        txtName.setLeftPaddingPoints(10)
        txtValid.setLeftPaddingPoints(10)
        txtCvv.setLeftPaddingPoints(10)
        
        txtName.placeholder  = "name".localized
        txtNumber.placeholder = "card_number_hint".localized
        txtValid.placeholder = "mm_txt_yy".localized
        txtCvv.placeholder  = "cvv_txt".localized
        btnSubmit.layer.cornerRadius = 8
        
        
        
        
        var validation = Validation()
        validation.minimumValue = 1
        
        txtValid.inputValidator = InputValidator(validation: validation)
        txtValid.formatter = CardExpirationDateFormatter()
        txtValid.inputType = .integer
        
        
        var numberVal = Validation()
        numberVal.maximumLength = "1234 5678 1234 5678".count
        numberVal.minimumLength = "1234 5678 1234 5678".count
        
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        txtNumber.inputValidator = inputValidator
        txtNumber.formatter = CardNumberFormatter()
        txtNumber.inputType = .integer
        txtNumber.clearButtonColor = .darkGray
        
    }
    
    
    @IBAction func btnSubmitFunc(_ sender: UIButton) {
        if isValidate() {
            delegate.onAddCardDetails(cardNumber: txtNumber.text!, cardExpire: txtValid.text!, cardCVV: txtCvv.text!)
            self.btnBackFunc(self)
        }
       
    }
    
    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   
}
extension CardDetailVC {
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
        
        if textField.tag == 2 {
            if finalString.count > 19 {
                return false
            }
        }
        else if textField.tag  == 3 {
            if finalString.count > 5 {
                return false
            }
        }
        else if textField.tag == 4 {
            if finalString.count > 4 {
                return false
            }
        }
        

      return true
    }
    
}
