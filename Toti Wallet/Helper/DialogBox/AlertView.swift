//
//  AlertView.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 27/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

protocol PopUpProtocol {
    func handleAction(action: Bool)
}

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var delegate: PopUpProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        alertView.layer.cornerRadius = 10
        btnOK.layer.cornerRadius = 8
        btnCancel.layer.cornerRadius = 8
        
        btnCancel.layer.borderWidth = 1
        btnCancel.layer.borderColor = #colorLiteral(red: 0.3959999979, green: 0.04699999839, blue: 0.2240000069, alpha: 1)
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(title: String, message: String) {
        self.titleLbl.text = title
        self.messageLbl.text = message
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func btnOKFunc(_ sender: UIButton) {
        self.delegate?.handleAction(action: true)
        parentView.removeFromSuperview()
    }
    
    @IBAction func btnCancelFunc(_ sender: UIButton) {
        self.delegate?.handleAction(action: true)
        parentView.removeFromSuperview()
    }
    
    func hideAlert() {
        parentView.removeFromSuperview()
    }
}

