//
//  RequestMoneyVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class RequestMoneyVC: BaseVC {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnRequestMoney: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        txtAmount.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        txtAmount.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        
        btnRequestMoney.layer.cornerRadius = 8
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        self.pushWithFullScreen(nextVC)
    }
   

    @IBAction func btnRequestFunc(_ sender: UIButton) {
        self.showAlert(title: "Request money", message: "Request sent successfully")
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
