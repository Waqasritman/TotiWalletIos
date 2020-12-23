//
//  AlertViewWithTextField.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

protocol AlertViewWithTextProtocol {
    func handleAction(txtFieldValue: String)
}

class AlertViewWithTextField: UIView {

    static let instance = AlertViewWithTextField()
    
    @IBOutlet weak var error_label: UILabel!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnOK: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    var delegate: AlertViewWithTextProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertViewWithTextField", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        alertView.layer.cornerRadius = 10
        btnOK.layer.cornerRadius = 8
        
        error_label.isHidden = true
        cancelBtn.layer.cornerRadius = 8
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        txtCVV.setLeftPaddingPoints(10)
        txtCVV.layer.cornerRadius = 8
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        error_label.isHidden = true
        error_label.text = "plz_enter_valid_cvv".localized
    }
    
    func showAlert(title: String, txtFieldPlaceHolder: String) {
        self.titleLbl.text = title
        txtCVV.placeholder = txtFieldPlaceHolder
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func btnOKFunc(_ sender: UIButton) {
        
        if !txtCVV.text!.isEmpty || txtCVV.text!.count >= 3 {
            self.delegate?.handleAction(txtFieldValue: txtCVV.text ?? "")
            parentView.removeFromSuperview()
        } else {
            error_label.isHidden = false
        }
        
       
    }
    
    @IBAction func cancelbtnclick(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    
    func hideAlert() {
        parentView.removeFromSuperview()
    }
 
}
