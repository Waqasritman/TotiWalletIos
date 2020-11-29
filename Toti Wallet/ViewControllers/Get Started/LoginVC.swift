//
//  LoginVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var checkBoxOutlet:UIButton!{
        didSet{
            checkBoxOutlet.setImage(UIImage(named:"unchecked"), for: .normal)
            checkBoxOutlet.setImage(UIImage(named:"checked"), for: .selected)
        }
    }
    
    @IBOutlet weak var viewVerificationCode: KWVerificationCodeView!
    var isByPhoneNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewVerificationCode.textFieldViews.forEach({ (KWTextFieldView) in
            KWTextFieldView.clipsToBounds = true
            KWTextFieldView.layer.cornerRadius = 8
        })
        
        btnLogin.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        if isByPhoneNumber {
            phoneNumberView.isHidden = false
            emailView.isHidden = true
        }
        else{
            phoneNumberView.isHidden = true
            emailView.isHidden = false
        }
    }
    
    
    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        //show countries here
    }
    
    @IBAction func checkbox(_ sender: UIButton){
        sender.checkboxAnimation {
            print(sender.isSelected)
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let nextVC = ControllerID.tabbar.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
