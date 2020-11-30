//
//  HistoryOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 29/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class HistoryOptionVC: UIViewController {

    @IBOutlet weak var viewTransction: UIButton!
    @IBOutlet weak var viewWallet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTransction.layer.cornerRadius = 8
        viewWallet.layer.cornerRadius = 8
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        
    }
    

}
