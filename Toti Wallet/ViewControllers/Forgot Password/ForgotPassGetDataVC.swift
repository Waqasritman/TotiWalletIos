//
//  ForgotPassGetDataVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import AYPopupPickerView

class ForgotPassGetDataVC: BaseVC {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var txtExpireDate: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var isByNumber = false
    var isDateSelected = false
    
    override func isValidate() -> Bool {
        if txtIDNumber.text!.isEmpty {
            return false
        } else if !isDateSelected {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIDNumber.setLeftPaddingPoints(10)
   
        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        txtExpireDate.imageEdgeInsets.left = self.view.frame.width - 50
        txtIDNumber.layer.cornerRadius = 8
        btnConfirm.layer.cornerRadius = 8
    }
    
    
    @IBAction func btnExpireDateClick(_ sender:Any) {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.datePickerView.datePickerMode = .date
        popupDatePickerView.datePickerView.maximumDate = Date()
        
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            self.txtExpireDate.setTitle(self.getFormatedPinDate(date: date), for: .normal)
            self.txtExpireDate.setTitleColor(UIColor.black, for: .normal)
            ForgotPinRequestApprovedUserRequest.shared.idExpireDate = self.getFormatedPinDate(date: date)
            self.isDateSelected = true
        })
       
    }
    
    
    @IBAction func btnNext(_ sender:Any) {
        if isValidate() {
            ForgotPinRequestApprovedUserRequest.shared.idNumber = txtIDNumber.text!
            let nextVc = ControllerID.forgotPassotpVC.instance
            (nextVc as! ForgotPassotpVC).isByNumber = self.isByNumber
            self.pushWithFullScreen(nextVc)
        }
       
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
