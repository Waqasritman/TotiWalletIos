//
//  BankDetailAlert.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

protocol BankDetailAlertProtocol {
    func handleAction()
}
class BankDetailAlert: UIView {

    static let instance = BankDetailAlert()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var lblReferenceNumber: UILabel!
    @IBOutlet weak var lblAccountTitle: UILabel!
    @IBOutlet weak var lblSortCode: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!

    var delegate: BankDetailAlertProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("BankDetailAlert", owner: self, options: nil)
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
    
    func showAlert(title: String, message: String, referenceNumber: String, accountTitle: String, bankSort: String, accountNumber: String) {
        self.titleLbl.text = title
        self.messageLbl.text = message
        self.lblReferenceNumber.text = referenceNumber
        self.lblAccountTitle.text = accountTitle
        self.lblSortCode.text = bankSort
        self.lblAccountNumber.text = accountNumber
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func btnOKFunc(_ sender: UIButton) {
        self.delegate?.handleAction()
        parentView.removeFromSuperview()
    }
    
    func hideAlert() {
        parentView.removeFromSuperview()
    }


    

}
