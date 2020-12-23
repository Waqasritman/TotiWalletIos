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
    
    @IBOutlet weak var btnDate: UIButton!
    var isByNumber = false
    var isDateSelected = false
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var idNumberLbl: UILabel!
    @IBOutlet weak var idExpireLbl: UILabel!
    
    
    
    override func isValidate() -> Bool {
        if txtIDNumber.text!.isEmpty {
            showError(message: "plz_enter_id_number".localized)
            return false
        } else if !isDateSelected {
            showError(message: "plz_enter_id_expire_date".localized)
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
        txtIDNumber.placeholder = "01234"
        btnDate.setTitle("date_hint".localized, for: .normal)
        pageTitle.text = "please_enter_details".localized
        idNumberLbl.text = "id_number_text".localized
        idExpireLbl.text = "id_expirey_date".localized
        btnConfirm.setTitle("continue_txt".localized, for: .normal)
    }
    
    
    @IBAction func btnExpireDateClick(_ sender:Any) {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.datePickerView.datePickerMode = .date
        //popupDatePickerView.datePickerView.minimumDate = Date()
        
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
