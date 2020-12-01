//
//  MyCardsVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MyCardsVC: UIViewController {

    
    @IBOutlet weak var viewGooglePay: UIView!
    @IBOutlet weak var viewPaytm: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewGooglePay.layer.cornerRadius = 8
        viewPaytm.layer.cornerRadius = 8
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }

}
