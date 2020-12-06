//
//  ReceiptVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {

    @IBOutlet weak var lblTXNnumber: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblSendingCurrency: UILabel!
    @IBOutlet weak var lblServiceFee: UILabel!
    @IBOutlet weak var lblOtherCharge: UILabel!
    @IBOutlet weak var lblVAT: UILabel!
    @IBOutlet weak var lblSendingAmount: UILabel!
    @IBOutlet weak var lblTotalPayable: UILabel!
    @IBOutlet weak var lblExchangeRate: UILabel!
    @IBOutlet weak var lblReceivingAmount: UILabel!
    @IBOutlet weak var lblPurposeTransfer: UILabel!
    @IBOutlet weak var lblCustomerID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblIDType: UILabel!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblBeneficaryName: UILabel!
    @IBOutlet weak var lblBeneficaryNumber: UILabel!
    @IBOutlet weak var lblBeneficaryAddress: UILabel!
    @IBOutlet weak var lblAvaialblePoints: UILabel!
    @IBOutlet weak var lblEarnedPoints: UILabel!
    
    @IBOutlet weak var viewTranscation: UIView!
    @IBOutlet weak var viewPayment: UIView!
    @IBOutlet weak var viewCustomer: UIView!
    @IBOutlet weak var viewBeneficiary: UIView!
    @IBOutlet weak var viewLoyalty: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTranscation.dropShadow()
        viewPayment.dropShadow()
        viewCustomer.dropShadow()
        viewBeneficiary.dropShadow()
        viewLoyalty.dropShadow()
        
        viewTranscation.layer.cornerRadius = 6
        viewPayment.layer.cornerRadius = 6
        viewCustomer.layer.cornerRadius = 6
        viewBeneficiary.layer.cornerRadius = 6
        viewLoyalty.layer.cornerRadius = 6
        
       
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
