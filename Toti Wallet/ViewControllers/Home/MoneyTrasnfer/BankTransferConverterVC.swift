//
//  BankTransferConverterVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BankTransferConverterVC: UIViewController {

    @IBOutlet weak var viewFirstCurrency: UIView!
    @IBOutlet weak var viewSecondCurrency: UIView!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtsecond: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var stackCommission: UIStackView!
    @IBOutlet weak var lblPayable: UILabel!
    @IBOutlet weak var lblSendingAmmount: UILabel!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var btnSource: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var btnSendNow: UIButton!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var viewPromo: UIView!
    @IBOutlet weak var txtPromo: UITextField!
    @IBOutlet weak var viewBottom: UIView!
    
    var isPriceViewVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewFirstCurrency.layer.cornerRadius = 8
        viewSecondCurrency.layer.cornerRadius = 8
        
        txtFirst.layer.cornerRadius = 8
        txtsecond.layer.cornerRadius = 8
        
        txtFirst.setLeftPaddingPoints(10)
        txtsecond.setLeftPaddingPoints(10)
        
        btnConvert.layer.cornerRadius = 8
        btnConvert.layer.borderWidth = 1
        btnConvert.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnSendNow.layer.cornerRadius = 8
        
        viewPromo.layer.cornerRadius = 8
        btnApply.layer.cornerRadius = 8
        btnApply.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        btnSource.layer.cornerRadius = 8
        btnTransfer.layer.cornerRadius = 8
        btnSendNow.layer.cornerRadius = 8
        
        btnSource.imageEdgeInsets.left = self.btnSource.frame.width - 25
        btnTransfer.imageEdgeInsets.left = self.btnTransfer.frame.width - 25
        
        viewPromo.layer.borderWidth = 0.5
        viewPromo.layer.borderColor = UIColor.black.cgColor
        
        txtPromo.setLeftPaddingPoints(10)
        
        
    }
    
    @IBAction func btnHidePriceFunc(_ sender: UIButton) {
        if isPriceViewVisible {
            stackCommission.isHidden = true
            isPriceViewVisible = false
            sender.setTitle("Show price break down", for: .normal)
        }
        else{
            stackCommission.isHidden = false
            isPriceViewVisible = true
            sender.setTitle("Hide price break down", for: .normal)
        }
    }
    
    @IBAction func btnConvertFunc(_ sender: UIButton) {
        viewBottom.isHidden = false
        btnConvert.isHidden = true
    }
    
    @IBAction func btnNowFunc(_ sender: UIButton) {
        let nextVC = ControllerID.summaryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
