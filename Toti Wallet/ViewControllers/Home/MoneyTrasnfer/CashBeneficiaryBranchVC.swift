//
//  CashBeneficiaryBranchVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficiaryBranchVC: UIViewController {

    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnBranch: UIButton!
    @IBOutlet weak var btnAddBeneficary: UIButton!
    @IBOutlet weak var stackBranch: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCity.layer.cornerRadius = 8
        btnLocation.layer.cornerRadius = 8
        btnBranch.layer.cornerRadius = 8
        btnAddBeneficary.layer.cornerRadius = 8
        
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   

}
