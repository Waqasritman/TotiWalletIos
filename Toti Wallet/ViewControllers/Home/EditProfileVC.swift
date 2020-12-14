//
//  EditProfileVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 14/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var txtCurrency: UITextField!
    @IBOutlet weak var txtPaymentMethod: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var imgOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgOutlet.layer.cornerRadius = imgOutlet.frame.height/2
        txtFirstName.layer.cornerRadius = 8
        txtLastName.layer.cornerRadius = 8
        txtNumber.layer.cornerRadius = 8
        txtEmail.layer.cornerRadius = 8
        btnDOB.layer.cornerRadius = 8
        txtCurrency.layer.cornerRadius = 8
        txtPaymentMethod.layer.cornerRadius = 8
        btnUpdate.layer.cornerRadius = 8
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
