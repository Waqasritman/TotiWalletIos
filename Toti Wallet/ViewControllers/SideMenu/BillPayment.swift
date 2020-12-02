//
//  BillPayment.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 01/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BillPayment: UIViewController {
    
    
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnOperator: UIButton!
    @IBOutlet weak var btnChoosePlan: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCountry.layer.cornerRadius = 8
        btnType.layer.cornerRadius = 8
        btnCategory.layer.cornerRadius = 8
        btnOperator.layer.cornerRadius = 8
        btnChoosePlan.layer.cornerRadius = 8
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnType.imageEdgeInsets.left = self.view.frame.width - 50
        btnCategory.imageEdgeInsets.left = self.view.frame.width - 50
        btnOperator.imageEdgeInsets.left = self.view.frame.width - 50
        
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
