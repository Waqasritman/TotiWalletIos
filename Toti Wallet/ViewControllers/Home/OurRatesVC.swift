//
//  OurRatesVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class OurRatesVC: BaseVC {

    let moneyTransferRepo:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnTransferNow: UIButton!
    @IBOutlet weak var firstDropDown: UIButton!
    @IBOutlet weak var secondDropDown: UIButton!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    
    
    
    override func isValidate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnTransferNow.layer.cornerRadius = 8
        
        firstDropDown.layer.cornerRadius = 8
        secondDropDown.layer.cornerRadius = 8
        txtFirst.layer.cornerRadius = 8
        txtSecond.layer.cornerRadius = 8
        
        firstDropDown.imageEdgeInsets.left = self.firstDropDown.frame.width - 25
        secondDropDown.imageEdgeInsets.left = self.secondDropDown.frame.width - 25
        
        txtFirst.setLeftPaddingPoints(5)
        txtSecond.setLeftPaddingPoints(5)
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        if let tabbar = tabBarController as? CustomTabBarController {
            tabbar.selectedIndex = 0
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }

}
