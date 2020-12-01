//
//  ProfileBasicDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ProfileBasicDetailVC: BaseVC {

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
    
    var gender:String = ""
    
    
    
    override func isValidate() -> Bool {
        if txtFirstName.text!.isEmpty {
            
            return false
        } else if txtMiddleName.text!.isEmpty {
            return false
        } else if txtLastName.text!.isEmpty {
            return false
        } else if txtFirstName.text!.count < 3 {
            return false
        } else if txtMiddleName.text!.count < 2 {
            return false
        } else if txtLastName.text!.count < 3 {
            return false
        } else if txtEmailAddress.text!.isEmpty {
            return false
        } else if !String().isValidEmailAddress(emailAddressString: txtEmailAddress.text!) {
            self.showError(message: "Invalid email address")
            return false
        }
        
        else if gender.isEmpty {
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
    

}
