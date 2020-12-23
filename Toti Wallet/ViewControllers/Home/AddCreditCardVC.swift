//
//  AddCreditCardVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 14/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import FormTextField
class AddCreditCardVC: BaseVC, UITextFieldDelegate {
    
    let repo:Repository = Repository()
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: FormTextField!
    @IBOutlet weak var txtExpireDat: FormTextField!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    @IBOutlet weak var validlbl: UILabel!
    @IBOutlet weak var numberlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    
    override func isValidate() -> Bool {
//        if txtName.text!.isEmpty {
//            showError(message: "enter_name".localized)
//            return false
//        } else
        if txtNumber.text!.isEmpty {
            showError(message: "enter_valid_card_number".localized)
            return false
        } else if txtExpireDat.text!.isEmpty {
            showError(message: "plz_enter_valid_expire_date".localized)
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
        
        var validation = Validation()
        validation.minimumValue = 1
        
        txtExpireDat.inputValidator = InputValidator(validation: validation)
        txtExpireDat.formatter = CardExpirationDateFormatter()
        txtExpireDat.inputType = .integer
        
        
        
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
      //  txtNumber.addTarget(self, action: #selector(reformatAsCardNumber(textField:)), for: .editingChanged)
  
        
        btnSubmit.layer.cornerRadius = 8
        
        txtName.delegate = self
        txtNumber.delegate = self
        txtExpireDat.delegate = self
        
        
        pageTitle.text = "add_card".localized
        namelbl.text = "name_on_card_txt".localized
        numberlbl.text = "number_on_card".localized
        validlbl.text = "valid_through".localized
        
        txtName.placeholder = "name".localized
        txtNumber.placeholder = "card_number_hint".localized
        txtExpireDat.placeholder = "mm_txt_yy".localized
        
        btnSubmit.setTitle("submit_txt".localized, for: .normal)
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
                request.languageId = preferenceHelper.getApiLangugae()
                
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
            
            if finalString.count > 19 {
                
                return false
            }
            
            
            if textField.text!.count < 19 {
                lblNumber.text = finalString
            }
        }
        else {

            if finalString.count > 5 {
                
                return false
            }
            
            if textField.text!.count < 5 {
              
                lblExpireDate.text = finalString
               // txtExpireDat.text = ""
               // txtExpireDat.text  = finalString
            }
          
        }
        
        return true
    }
    
    
    
    func expireFormat(string:String) -> String {
        var cleanString = string.replacingOccurrences(of: "/", with: "")
        if cleanString.rangeOfCharacter(from: .illegalCharacters) != nil {
            return ""
        }
        
        let dateString: String
        
        if cleanString.count == 0 {
            return string
        } else if cleanString.count > 4 {
            // trim the string down to 4
            
            let reqIndex = cleanString.index(cleanString.startIndex, offsetBy: 4)
            cleanString = String(cleanString[..<reqIndex])
        
        }
        
        if cleanString.hasPrefix("0") == false && cleanString.hasPrefix("1") == false {
            dateString = "0" + cleanString
        } else {
            dateString = cleanString
        }
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
        var newText = ""
        for (index, character) in dateString.enumerated() {
            print("index: \(index)")
            if index == 1 {
                let enterdMonth = Int(dateString.prefix(2)) ?? 0  // get first two digit from entered string as month
                print("enterdMonth at 1:\(enterdMonth)")
                if (1 ... 12).contains(enterdMonth){
                    if enterdMonth < 10 {
                        newText = "0" + "\(enterdMonth)" + "/"
                    }else {
                        newText = "\(enterdMonth)" + "/"
                    }
                }else{
                    
                }
            }else if index == 2 {
                if (2 ... 99).contains(Int(String(character))!) { // Entered year should be greater than 2019.
                    newText.append(character)
                }else{
                    
                }
            }else if index == 3 {
                print("index---: \(index)")
                let enterdYr = Int(dateString.suffix(2)) ?? 0   // get last two digit from entered string as year
                let enterdMonth = Int(dateString.prefix(2)) ?? 0  // get first two digit from entered string as month
                print("enterdYr: \(enterdYr)")
                print("currentYear: \(currentYear)")
                if (2 ... 99).contains(enterdYr) { // Entered year should be greater than 2019
                    if enterdYr >= currentYear {
                        if (1 ... 12).contains(enterdMonth) {
                            if enterdMonth < 10 {
                                newText = "0" + "\(enterdMonth)" + "/" + "\(enterdYr)"
                            }else {
                                newText = "\(enterdMonth)" + "/" + "\(enterdYr)"
                            }
                            return newText
                        }
                    }
                }
            }
            else {
                newText.append(character)
            }
        }
        return newText
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
    
    @objc
    func reformatAsCardNumber(textField:UITextField){
       print(textField.text!.count)

      let formatter = CreditCardFormatter()
      formatter.formatToCreditCardNumber(isAmex: false, textField: textField, withPreviousTextContent: textField.text, andPreviousCursorPosition: textField.selectedTextRange)
    }
    
}
