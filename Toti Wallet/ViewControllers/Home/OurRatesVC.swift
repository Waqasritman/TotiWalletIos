//
//  OurRatesVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class OurRatesVC: UIViewController {

    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnTransferNow: UIButton!
    @IBOutlet weak var firstDropDown: DropDown!
    @IBOutlet weak var secondDropDown: DropDown!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    
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
        
        txtFirst.setLeftPaddingPoints(5)
        txtSecond.setLeftPaddingPoints(5)
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }

}
