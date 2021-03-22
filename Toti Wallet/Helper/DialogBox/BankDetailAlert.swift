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

    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var referlbl: UILabel!
    
    @IBOutlet weak var acnolbl: UILabel!
    @IBOutlet weak var sortcodelbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var yemenSTack: UIStackView!
    @IBOutlet weak var simpleStack: UIStackView!
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
    
    
        titleLbl.text = "bank_details_txt".localized
        messageLbl.text = "bank_depost_message".localized
        referlbl.text = "refer_no".localized
        titlelbl.text = "bank_account_title_txt".localized
        sortcodelbl.text = "sort_code".localized
        acnolbl.text = "account_number".localized
        
        btnOK.setTitle("okay".localized, for: .normal)
    }
    
    func showAlert(referenceNumber: String , isYemen:Bool) {
//        self.titleLbl.text = "Bank Details"
//        self.messageLbl.text = "Please transfer/deposit the amount into the below bank account"
        self.lblReferenceNumber.text = referenceNumber
        self.lblAccountTitle.text = "TotiPay Limited"
        self.lblSortCode.text = "04-29-31"
        self.lblAccountNumber.text = "34587240"
        
        if isYemen {
            yemenSTack.isHidden = false
            simpleStack.isHidden = true
            viewHeight.constant = 380
        } else {
            yemenSTack.isHidden = true
            simpleStack.isHidden = false
            viewHeight.constant = 340
        }
        
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
