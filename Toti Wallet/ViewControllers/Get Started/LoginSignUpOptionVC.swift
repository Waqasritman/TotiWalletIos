//
//  LoginSignUpOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import AYPopupPickerView
class LoginSignUpOptionVC: BaseVC {

    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnExistingCustomer: UIButton!
    
    @IBOutlet weak var titlePage:UILabel!
    
    @IBOutlet weak var viewLang: UIView!
    @IBOutlet weak var langBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCreateAccount.layer.cornerRadius = 8
        btnExistingCustomer.layer.cornerRadius = 8

        btnCreateAccount.setTitle("create".localized, for: .normal)
        btnExistingCustomer.setTitle("already".localized, for: .normal)
        titlePage.text = "textOffer".localized

    }
    
    @IBAction func btnCreateAccountFunc(_ sender: UIButton) {
        let nextVC = ControllerID.signUpVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func lngbBtnClick(_ sender: Any) {
        let itemsTitle = ["English","Arabic"]
        let popupPickerView = AYPopupPickerView()
        popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
            let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
            self.langBtn.setTitle(itemsTitle[selectedIndex], for: .normal)  
            self.showProgress()
            preferenceHelper.setLanguage(String(selectedIndex))
            self.changed(selectedIndex)
        })
    }
    @IBAction func btnEsitingCustomerFunc(_ sender: UIButton) {
        let nextVC = ControllerID.loginOptionVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
}
