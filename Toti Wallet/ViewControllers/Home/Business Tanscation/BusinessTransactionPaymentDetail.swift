//
//  BusinessTransactionPaymentDetail.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BusinessTransactionPaymentDetail: UIViewController {

    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtAmmount: UITextField!
    @IBOutlet weak var txtCharges: UITextField!
    @IBOutlet weak var btnPurpose: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCountry.layer.cornerRadius = 8
        txtAmmount.layer.cornerRadius = 8
        txtCharges.layer.cornerRadius = 8
        btnPurpose.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        txtAmmount.setLeftPaddingPoints(10)
        txtCharges.setLeftPaddingPoints(10)
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnPurpose.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        let nextVC = ControllerID.businessTransctionBankDetail.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
