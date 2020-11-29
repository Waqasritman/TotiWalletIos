//
//  ProfileBasicDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ProfileBasicDetailVC: UIViewController {

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
    
    @IBAction private func maleFemaleAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        print(sender.tag)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    

    @IBAction func btnNextFunc(_ sender: UIButton) {
        let nextVC = ControllerID.profileAddressDetailVC.instance
        self.pushWithFullScreen(nextVC)
    }
    

}
