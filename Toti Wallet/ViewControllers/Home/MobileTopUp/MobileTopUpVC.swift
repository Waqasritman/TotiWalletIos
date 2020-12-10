//
//  MobileTopUpVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MobileTopUpVC: UIViewController {
    
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var btnChoosePlan: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var btnOperator: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnType.layer.cornerRadius = 8
        btnOperator.layer.cornerRadius = 8
        
        btnChoosePlan.layer.cornerRadius = 8
        txtPhoneNumber.setLeftPaddingPoints(5)
        
        btnType.imageEdgeInsets.left = self.view.frame.width - 50
        btnOperator.imageEdgeInsets.left = self.view.frame.width - 50
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        let nextVC = ControllerID.selectPlanVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnSelectTypeFunc(_ sender: UIButton) {
        let nextVC = ControllerID.simTypeVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnSelectOperatorFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
