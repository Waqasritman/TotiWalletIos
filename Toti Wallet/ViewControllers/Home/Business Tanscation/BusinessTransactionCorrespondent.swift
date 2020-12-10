//
//  BusinessTransactionCorrespondent.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTransactionCorrespondent: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSwift: UITextField!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.setLeftPaddingPoints(10)
        txtSwift.setLeftPaddingPoints(10)
        txtAccount.setLeftPaddingPoints(10)
        
        txtName.layer.cornerRadius = 8
        txtSwift.layer.cornerRadius = 8
        txtAccount.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
