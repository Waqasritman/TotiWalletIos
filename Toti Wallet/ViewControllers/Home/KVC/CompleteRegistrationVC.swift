//
//  CompleteRegistrationVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CompleteRegistrationVC: UIViewController {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var lblRegistrationType: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var lblIDType: UILabel!
    @IBOutlet weak var btnIDType: UIButton!
    @IBOutlet weak var lblIDNumber: UILabel!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var btnIssueDate: UIButton!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var btnExpireDate: UIButton!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var dobStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        txtNumber.setLeftPaddingPoints(10)
        
        btnCountry.layer.cornerRadius = 8
        btnIDType.layer.cornerRadius = 8
        txtNumber.layer.cornerRadius = 8
        btnIssueDate.layer.cornerRadius = 8
        btnExpireDate.layer.cornerRadius = 8
        btnDOB.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnIDType.imageEdgeInsets.left = self.view.frame.width - 50
        btnIssueDate.imageEdgeInsets.left = self.view.frame.width - 50
        btnExpireDate.imageEdgeInsets.left = self.view.frame.width - 50
        btnDOB.imageEdgeInsets.left = self.view.frame.width - 50
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
        
        setLabels()
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnSwitchFunc(_ sender: UISwitch) {
        setLabels()
    }
    
    func setLabels() {
        if switchOutlet.isOn == false {
            lblRegistrationType.text = "Individual registration"
            lblCountry.text = "ID issuance country"
            btnCountry.setTitle("select Country", for: .normal)
            lblIDType.text = "ID type"
            btnIDType.setTitle("Please select ID type", for: .normal)
            lblIDNumber.text = "ID Number"
            txtNumber.placeholder = "Enter number"
            lblIssueDate.text = "ID issue date"
            btnIssueDate.setTitle("mm/dd/yyyy", for: .normal)
            lblExpireDate.text = "ID expire date"
            btnExpireDate.setTitle("mm/dd/yyyy", for: .normal)
            dobStackView.isHidden = false
            
        }
        else {
            lblRegistrationType.text = "Business registration"
            lblCountry.text = "Business issuance country"
            btnCountry.setTitle("select Country", for: .normal)
            lblIDType.text = "Business id type"
            btnIDType.setTitle("Please select ID type", for: .normal)
            lblIDNumber.text = "Business id number"
            txtNumber.placeholder = "1234"
            lblIssueDate.text = "Business id issue date"
            btnIssueDate.setTitle("mm/dd/yyyy", for: .normal)
            lblExpireDate.text = "Business id expire date"
            btnExpireDate.setTitle("mm/dd/yyyy", for: .normal)
            dobStackView.isHidden = true
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
