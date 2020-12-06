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
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnOK: UIButton!
    
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
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(title: String, txtFieldPlaceHolder: String) {
        self.titleLbl.text = title
        txtCVV.placeholder = txtFieldPlaceHolder
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func btnOKFunc(_ sender: UIButton) {
        self.delegate?.handleAction(txtFieldValue: txtCVV.text ?? "")
        parentView.removeFromSuperview()
    }
    
    func hideAlert() {
        parentView.removeFromSuperview()
    }
 
}
