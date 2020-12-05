//
//  CardDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CardDetailVC: BaseVC {
    
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    let mask = "##/##"
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtValid: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    
    
    var delegate:CardSumitProtocol!
    
    
    override func isValidate() -> Bool {
        if txtName.text!.isEmpty {
            return false
        } else if txtNumber.text!.isEmpty {
            return false
        } else if txtValid.text!.isEmpty {
            return false
        } else if txtCvv.text!.isEmpty {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btnSubmit.layer.cornerRadius = 8
       // txtValid.delegate = self
    }
    
    
    @IBAction func btnSubmitFunc(_ sender: UIButton) {
        delegate.onAddCardDetails(cardNumber: txtNumber.text!, cardExpire: txtValid.text!, cardCVV: txtCvv.text!)
        self.btnBackFunc(self)
    }
    
    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   
}
extension CardDetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let normalText = textField.text else { return false }

        let beginning = textField.beginningOfDocument
        // save cursor location
        let cursorLocation = textField.position(from: beginning, offset: range.location + string.count)

        let newString = (normalText as NSString).replacingCharacters(in: range, with: string)
        let newStringClean = newString.stringWithOnlyNumbers().withMask(mask: mask)

        guard newString != newStringClean else { return true }

        textField.text = newStringClean
        guard string != "" else { return false }

        // fix cursor location after changing textfield.text
        if let cL = cursorLocation {
            let textRange = textField.textRange(from: cL, to: cL)
            textField.selectedTextRange = textRange
        }

        return false
    }
}
extension String {
    func stringWithOnlyNumbers() -> String {
        return self.reduce("") { (acc, c) -> String in
            guard c.isDigit() else { return acc }
            return "\(acc)\(c)"
        }
    }

    func withMask(mask: String) -> String {
        var resultString = String()

        let chars = self
        let maskChars = mask

        var stringIndex = chars.startIndex
        var maskIndex = mask.startIndex

        while stringIndex < chars.endIndex && maskIndex < maskChars.endIndex {
            if (maskChars[maskIndex] == "#") {
                resultString.append(chars[stringIndex])
                stringIndex = chars.index(after: stringIndex)
            } else {
                resultString.append(maskChars[maskIndex])
            }
            maskIndex = chars.index(after: maskIndex)
        }

        return resultString
    }

}
extension Character {
    func isDigit() -> Bool {
        let s = String(self).unicodeScalars
        let uni = s[s.startIndex]

        let digits = NSCharacterSet.decimalDigits
        let isADigit = digits.hasMember(inPlane: UInt8(uni.value))

        return isADigit
    } }


