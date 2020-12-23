//
//  ReceiptVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class ReceiptVC: BaseVC {

    
    @IBOutlet weak var shareView: UIView!
    let repo : MoneyTransferRepository = MoneyTransferRepository()
     var comeFromHome = true
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
    
    
    @IBOutlet weak var bankAccountno: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankCode: UILabel!
    @IBOutlet weak var bankBranch: UILabel!
    
    
    
    @IBOutlet weak var transDetaillbl: UILabel!
    @IBOutlet weak var txtnumberlbl: UILabel!
    @IBOutlet weak var dateandtimelbl: UILabel!
    
    @IBOutlet weak var paymentdetaillbl: UILabel!
    @IBOutlet weak var sendingCurrnylbl: UILabel!
    @IBOutlet weak var servicelbl: UILabel!
    @IBOutlet weak var otherChargelbl: UILabel!
    @IBOutlet weak var vatlbl: UILabel!
    @IBOutlet weak var sendingamountlbl: UILabel!
    @IBOutlet weak var totalpayablelbl: UILabel!
    @IBOutlet weak var exchangeratelbl: UILabel!
    @IBOutlet weak var receivingAmountlbl: UILabel!
    @IBOutlet weak var purposelbl: UILabel!
    
    @IBOutlet weak var bankDetailslbl: UILabel!
    @IBOutlet weak var bankAcountlbl: UILabel!
    
    @IBOutlet weak var bankbranchlbl: UILabel!
    @IBOutlet weak var bankcodelbl: UILabel!
    @IBOutlet weak var banknamelbl: UILabel!
    
    @IBOutlet weak var customerlbl: UILabel!
    @IBOutlet weak var customerIDlbl: UILabel!
    @IBOutlet weak var customernamlbl: UILabel!
    @IBOutlet weak var customermobiellbl: UILabel!
    @IBOutlet weak var customeraddresslbl: UILabel!
    @IBOutlet weak var idtypelbl: UILabel!
    @IBOutlet weak var releationllb: UILabel!
    
    @IBOutlet weak var benedetailslbl: UILabel!
    @IBOutlet weak var benenamelbl: UILabel!
    @IBOutlet weak var benemobilelbl: UILabel!
    @IBOutlet weak var beneaddresslbl: UILabel!
    
    
    @IBOutlet weak var loyaltypointdetlbl: UILabel!
    @IBOutlet weak var avialPointlbl: UILabel!
    @IBOutlet weak var earnedpointlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transDetaillbl.text = "transaction_details".localized
        txtnumberlbl.text = "txn_number".localized
        dateandtimelbl.text = "date_amp_time".localized
        
        paymentdetaillbl.text = "payment_details".localized
        sendingCurrnylbl.text = "sending_currency".localized
        servicelbl.text = "service_fee".localized
        otherChargelbl.text = "other_charge".localized
        vatlbl.text = "vat_10_00".localized
        sendingamountlbl.text = "sending_amount".localized
        totalpayablelbl.text = "total_payable".localized
        exchangeratelbl.text = "exchange_rate".localized
        receivingAmountlbl.text = "receiving_amount".localized
        purposelbl.text = "purpose_of_transfer_txt".localized
        
        bankDetailslbl.text = "bank_details".localized
        bankAcountlbl.text = "account_no_txt_t".localized
        
        bankbranchlbl.text = "branch".localized
        bankcodelbl.text = "bank_code".localized
        banknamelbl.text = "bank_name_txt".localized
        
        customerlbl.text = "customer_details".localized
        customerIDlbl.text = "customer_id".localized
        customernamlbl.text = "name".localized
        customermobiellbl.text = "mobile_number_txt".localized
        customeraddresslbl.text = "address_txt".localized
        idtypelbl.text = "id_type".localized
        releationllb.text = "relation_with_beneficiary_txt".localized
        
        benedetailslbl.text = "beneficiary_details".localized
        benenamelbl.text = "name".localized
        benemobilelbl.text = "mobile_number_txt".localized
        beneaddresslbl.text = "address_txt".localized
        
        
        loyaltypointdetlbl.text = "loyalty_points_details".localized
        avialPointlbl.text = "avail_points".localized
        earnedpointlbl.text = "earn_points".localized
        
        viewTranscation.dropShadow()
        viewPayment.dropShadow()
        viewCustomer.dropShadow()
        viewBeneficiary.dropShadow()
        viewLoyalty.dropShadow()
        viewBank.dropShadow()
        
        let floaty = Floaty()
        floaty.buttonImage = #imageLiteral(resourceName: "share_btn")
        floaty.size = 45
        floaty.buttonColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        self.view.addSubview(floaty)


        floaty.handleFirstItemDirectly = true
        floaty.addItem("" , icon: nil , handler: { item in
            self.shareViewClick(self)
        })

        
    
        
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
    
    
    
    @IBAction func shareViewClick(_ sender:Any) {
        let image = shareView.takeScreenshot()
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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
        
        
        if receipt.paymentMode != "Bank Transfer" {
            viewBank.isHidden = true
        } else {
            bankAccountno.text = receipt.bankAccountNo
            bankName.text = receipt.bankName
            bankCode.text = receipt.bankCode
            bankBranch.text = receipt.bankBranch
        }
        
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        if comeFromHome {
            self.navigationController?.popViewController(animated: true)
        } else {
            gotoHome()
        }
       
    }

}
