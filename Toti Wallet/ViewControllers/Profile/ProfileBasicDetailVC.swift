//
//  ProfileBasicDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ProfileBasicDetailVC: BaseVC , UITextFieldDelegate {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(#imageLiteral(resourceName: "radioUnchecked"), for: .normal)
                button.setImage(#imageLiteral(resourceName: "radioChecked"), for: .selected)
            }
        }
    }
    
    @IBOutlet weak var pagetitle: UILabel!
    @IBOutlet weak var firstNamelbl: UILabel!
    @IBOutlet weak var middleNamelbl: UILabel!
    @IBOutlet weak var lastNamelbl: UILabel!
    
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var emailAddresslbl: UILabel!
    
    var gender:String = ""
    
 
    override func isValidate() -> Bool {
        if txtFirstName.text!.isEmpty {
            showError(message: "enter_first_name".localized)
            return false
        } else if txtMiddleName.text!.isEmpty {
            showError(message: "enter_middle_name_error".localized)
            return false
        } else if txtLastName.text!.isEmpty {
            showError(message: "enter_last_name".localized)
            return false
        } else if txtFirstName.text!.count < 3 {
            showError(message: "first_name_greate_than_3".localized)
            return false
        } else if txtMiddleName.text!.count < 2 {
            showError(message: "middle_name_greate_than_3".localized)
            return false
        } else if txtLastName.text!.count < 3 {
            showError(message: "last_name_greate_than_3".localized)
            return false
        } else if txtEmailAddress.text!.isEmpty {
            showError(message: "enter_email_error".localized)
            return false
        } else if !String().isValidEmailAddress(emailAddressString: txtEmailAddress.text!) {
            self.showError(message: "invalid_email_address_txt".localized)
            return false
        }
        
        else if gender.isEmpty {
            self.showError(message: "select_gender".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        txtFirstName.layer.cornerRadius = 8
        txtMiddleName.layer.cornerRadius = 8
        txtLastName.layer.cornerRadius = 8
        txtEmailAddress.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtFirstName.setLeftPaddingPoints(8)
        txtLastName.setLeftPaddingPoints(8)
        txtMiddleName.setLeftPaddingPoints(8)
        txtEmailAddress.setLeftPaddingPoints(8)
        
        setLabels()
        
        txtFirstName.delegate = self
        txtMiddleName.delegate = self
        txtLastName.delegate = self
        
    }
    
    
    func setLabels(){
        pagetitle.text = "create_your_profile".localized
        firstNamelbl.text = "first_name".localized
        txtFirstName.placeholder = "first_name_text".localized
        middleNamelbl.text = "middle_name_txt".localized
        txtMiddleName.placeholder = "middle_name".localized
        
        lastNamelbl.text = "last_name_text_m".localized
        txtLastName.placeholder = "last_name_text".localized
        emailAddresslbl.text = "email".localized
        txtEmailAddress.placeholder = "email_txt".localized
        genderLbl.text = "gender".localized
        maleBtn.setTitle("male".localized, for: .normal)
        femaleBtn.setTitle("female".localized, for: .normal)
        btnNext.setTitle("next".localized, for: .normal)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !RegisterUserRequest.shared.email.isEmpty && RegisterUserRequest.shared.phoneNumber.isEmpty {
            txtEmailAddress.text = RegisterUserRequest.shared.email
            txtEmailAddress.isEnabled = false
        }
        
    }
    
    @IBAction private func maleFemaleAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        gender = String((sender.titleLabel!.text!.prefix(1)))
        print(gender)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    

    @IBAction func btnNextFunc(_ sender: UIButton) {
        
        if isValidate() {
            RegisterUserRequest.shared.firstName = txtFirstName.text!
            RegisterUserRequest.shared.middleName = txtMiddleName.text!
            RegisterUserRequest.shared.lastName = txtLastName.text!
            RegisterUserRequest.shared.gender = gender
            RegisterUserRequest.shared.email = txtEmailAddress.text!
            let nextVC = ControllerID.profileAddressDetailVC.instance
            self.pushWithFullScreen(nextVC)
        }
    }
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField.isFirstResponder {
                let validString = CharacterSet(charactersIn: " !@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢1234567890")

                if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
                    return false
                }
                if let range = string.rangeOfCharacter(from: validString)
                {
                    print(range)
                    return false
                }
            }
            return true
        }
}
