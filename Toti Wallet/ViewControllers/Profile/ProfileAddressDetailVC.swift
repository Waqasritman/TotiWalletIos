//
//  ProfileAddressDetailVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ProfileAddressDetailVC: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnCountryName: UIButton!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnNationality: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMain.layer.cornerRadius = 16
        viewMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnCountryName.layer.cornerRadius = 8
        txtCity.layer.cornerRadius = 8
        txtAddress.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        
        btnCountryName.imageEdgeInsets.left = self.view.frame.width - 60
        btnNationality.imageEdgeInsets.left = self.view.frame.width - 60
    }
    
    @IBAction func btnShowCountriesFunc(_ sender: UIButton) {
        //show countries here
    }
    
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
