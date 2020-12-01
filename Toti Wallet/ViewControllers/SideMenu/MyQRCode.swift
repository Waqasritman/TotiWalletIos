//
//  MyQRCode.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 01/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MyQRCode: UIViewController {

    @IBOutlet weak var btnShare: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnShare.layer.cornerRadius = 8
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
