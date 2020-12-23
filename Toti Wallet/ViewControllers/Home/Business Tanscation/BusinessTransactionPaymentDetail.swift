//
//  BusinessTransactionPaymentDetail.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

protocol SwiftPurposeProtocol {
    func onSelectPurpose(purpose:String , index:Int)
}

class BusinessTransactionPaymentDetail: BaseVC , CountryListProtocol
                                        , SwiftPurposeProtocol {
  
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtAmmount: UITextField!
    @IBOutlet weak var txtCharges: UITextField!
    @IBOutlet weak var btnPurpose: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtOthers:UITextField!
    @IBOutlet weak var otherlbl:UILabel!
    
    var isCountrySelected = false
    var purposeTypeSelected = false
    
    
    @IBOutlet weak var toolTitle: UILabel!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var receivingcountrylbl: UILabel!
    
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var chargeslbl: UILabel!
    @IBOutlet weak var purposelbl: UILabel!
    
    
    override func isValidate() -> Bool {
        if !isCountrySelected {
            showError(message: "enter_rece_country".localized)
            return false
        } else if txtAmmount.text!.isEmpty {
            showError(message: "enter_the_amount".localized)
            return false
        } else if txtCharges.text!.isEmpty {
            showError(message: "select_the_purpose_txt".localized)
            return false
        } else if !txtOthers.isHidden  && txtOthers.text!.isEmpty {
            showError(message: "enter_purpose_of_transfer".localized)
            return false
        } else if !purposeTypeSelected {
            showError(message: "enter_purpose_of_transfer".localized)
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCountry.layer.cornerRadius = 8
        txtAmmount.layer.cornerRadius = 8
        txtCharges.layer.cornerRadius = 8
        btnPurpose.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        txtOthers.layer.cornerRadius = 8
        txtAmmount.setLeftPaddingPoints(10)
        txtCharges.setLeftPaddingPoints(10)
        txtCharges.text = "50"
        txtCharges.isEnabled = false
        btnCountry.imageEdgeInsets.left = self.view.frame.width - 50
        btnPurpose.imageEdgeInsets.left = self.view.frame.width - 50
        
        
        toolTitle.text = "swift_transfer".localized
        pageTitle.text = "enter_payment_details".localized
        receivingcountrylbl.text = "rece_country".localized
        amountlbl.text = "receiving_amount_m".localized
        chargeslbl.text = "charges_txt_m".localized
        purposelbl.text = "purpose_of_transfer_m".localized
        otherlbl.text = "others_txt_m".localized
        
        btnCountry.setTitle("Republic of China", for: .normal)
        txtAmmount.placeholder = "amount_hint".localized
        btnPurpose.setTitle("select_the_purpose_txt".localized, for: .normal)
        txtOthers.placeholder = "purpose_of_transfer".localized
    }
    
    
    @IBAction func btnCountryClick(_ sender:UIButton) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnOnPurposeClick(_ sender:Any) {
        let nextVC = ControllerID.swiftPurposeVC.instance
        (nextVC as! SwiftPurposeVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        if isValidate() {
            B2BTransferDetails.shared.payInAmount = "0.0"
            B2BTransferDetails.shared.payOutAmount = txtAmmount.text!
            B2BTransferDetails.shared.charges = txtCharges.text!
            
            if !txtOthers.isHidden {
                B2BTransferDetails.shared.purposeOfTransfer = txtOthers.text!
            } else {
                B2BTransferDetails.shared.purposeOfTransfer = btnPurpose.titleLabel!.text!
            }
            
            let nextVC = ControllerID.businessTransctionBankDetail.instance
            self.pushWithFullScreen(nextVC)
        }

    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    func onSelectCountry(country: WRCountryList) {
        btnCountry.setTitle(country.countryName, for: .normal)
        btnCountry.setTitleColor(.black, for: .normal)
        B2BTransferDetails.shared.receivingCountry = country.countryShortName
        B2BTransferDetails.shared.receivingCurrency = country.currencyShortName
        isCountrySelected = true
    }
    
    
    func onSelectPurpose(purpose: String, index: Int) {
        btnPurpose.setTitle(purpose, for: .normal)
        btnPurpose.setTitleColor(.black, for: .normal)
        purposeTypeSelected = true
        if index == 1 {
            otherlbl.isHidden = false
            txtOthers.isHidden = false
        } else {
            otherlbl.isHidden = true
            txtOthers.isHidden = true
        }
    }
    
    
}
