//
//  ReceiptVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ReceiptVC: BaseVC {

    
    let repo : MoneyTransferRepository = MoneyTransferRepository()
     
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
    @IBOutlet weak var viewBank:UIView!
   
    var tranactionNumber:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTranscation.dropShadow()
        viewPayment.dropShadow()
        viewCustomer.dropShadow()
        viewBeneficiary.dropShadow()
        viewLoyalty.dropShadow()
        viewBank.dropShadow()
        
        let floaty = Floaty()
        floaty.buttonImage = #imageLiteral(resourceName: "share")
        floaty.size = 45
        floaty.buttonColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        self.view.addSubview(floaty)
        
        viewTranscation.layer.cornerRadius = 6
        viewPayment.layer.cornerRadius = 6
        viewCustomer.layer.cornerRadius = 6
        viewBeneficiary.layer.cornerRadius = 6
        viewLoyalty.layer.cornerRadius = 6
        viewBank.layer.cornerRadius = 6
       
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetTransactionReceiptRequest()
            request.transactionNumber = tranactionNumber
            request.languageId = preferenceHelper.getLanguage()
            repo.getReceipt(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_TRANSACTION_RECEIPT), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showReceipt(receipt: response!)
                } else {
                    self.showError(message: response!.description!)
                }
            })
        } else {
            self.noInternet()
            
        }
    }
    
    
    
    func showReceipt(receipt:TransactionReceipt) {
        lblTXNnumber.text = receipt.transactionNumber
        lblDateTime.text = receipt.transactionDateTime
        lblSendingCurrency.text = receipt.payInCurrency
        lblServiceFee.text = String(format: "%.02f",receipt.commissionCharge)
        lblOtherCharge.text = String(format: "%.02f",receipt.otherCharge)
        lblVAT.text = String(format: "%.02f", receipt.vatPercentage)
        lblSendingAmount.text = String(format: "%.02f", receipt.sendingAmount)
        lblTotalPayable.text = String(format: "%.02f", receipt.totalPayable)
        lblExchangeRate.text = String(format: "%.02f", receipt.exchangeRate)
        lblReceivingAmount.text = String(format: "%.02f", receipt.receivingAmount)
        lblPurposeTransfer.text = receipt.purposeOfTransfer
        lblCustomerID.text = preferenceHelper.getCustomerNo()
        lblName.text = receipt.remitterName
        lblMobileNumber.text =  receipt.remitterContactNo
        lblAddress.text = receipt.remitterAddress
        lblIDType.text = receipt.idType
        lblRelation.text = receipt.relationWithBeneficiary
        
        lblBeneficaryName.text = receipt.beneficiaryName
        lblBeneficaryNumber.text = receipt.beneficiaryContactNo
        lblBeneficaryAddress.text =  receipt.beneficiaryAddress
        lblAvaialblePoints.text =  receipt.availPoints
        lblEarnedPoints.text = receipt.earnPoint
        
        
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
