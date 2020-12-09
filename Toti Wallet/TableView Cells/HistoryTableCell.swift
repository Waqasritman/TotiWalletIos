//
//  HistoryTableCell.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 05/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

protocol ReceiptDelegate {
    func onClickReceipt(history:TransactionHistory)
}

protocol RepeatDelegate {
    func onClickRepeat(history:WalletHistory)
}

class HistoryTableCell: UITableViewCell {

    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnReceipt: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTransferType: UILabel!
    
    var history:TransactionHistory!
    var walletHistory:WalletHistory!
    
    var receiptDelegate:ReceiptDelegate!
    var walletDelegate:RepeatDelegate!
    
    @IBAction func onClickReceipt(_ sender:Any) {
        if receiptDelegate != nil {
            receiptDelegate.onClickReceipt(history: history)
        } else if walletDelegate != nil {
            walletDelegate.onClickRepeat(history: walletHistory)
        }
    }
    
    
    func setTransactionHistoryData(history:TransactionHistory) {
        self.history = history
      
        lblName.text = history.receiverName
        lblType.text = history.paymentType
        lblDate.text = history.transactionDate
        lblAmount.text = history.sendingAmount + " " + history.currency
        lblStatus.text = history.status
        if history.paymentTypeID == 1 || history.paymentTypeID == 2 {
            btnReceipt.isHidden = false
        } else {
            btnReceipt.isHidden = true
        }
    }
    
    
    func setWalletHistoryData(history:WalletHistory) {
        self.walletHistory = history
        lblDate.text = walletHistory.transactionDate
        lblType.text = walletHistory.paymentType
        lblAmount.text = walletHistory.sendingAmount + " " + walletHistory.sendingCurrency
        lblStatus.text = walletHistory.status
        
        if walletHistory.status.lowercased().elementsEqual("received") {
            lblTransferType.text = "Received from"
            lblName.text = walletHistory.senderName
            btnReceipt.isHidden = true
        } else {
            lblTransferType.text = "Transfer to"
            lblName.text = walletHistory.receiverName
            btnReceipt.isHidden = false
        }
        
        //means its load wallet
        if walletHistory.paymentTypeID == 66 {
            btnReceipt.isHidden = true
        }
    }
    
    
}

extension UITableViewCell {
    /// Call this method from `prepareForReuse`, because the cell needs to be already rendered (and have a size) in order for this to work
    func shadowDecorate(radius: CGFloat = 8,
                        shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
                        shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                        shadowRadius: CGFloat = 3,
                        shadowOpacity: Float = 0.4) {
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
