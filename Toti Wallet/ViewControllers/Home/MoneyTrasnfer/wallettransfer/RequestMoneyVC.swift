//
//  RequestMoneyVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 03/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class RequestMoneyVC: BaseVC  , CountryListProtocol {
    
    let moneyRepo:MoneyTransferRepository = MoneyTransferRepository()
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnRequestMoney: UIButton!
    @IBOutlet weak var codeLbl:UILabel!
    
    @IBOutlet weak var flagIcon: UIImageView!
    
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var toolTitlelbl: UILabel!
    @IBOutlet weak var pageTitlelbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    override func isValidate() -> Bool {
        
        if codeLbl.text!.isEmpty {
            self.showError(message: "plz_select_country_code".localized)
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            self.showError(message: "enter_mobile_no_error".localized)
            return false
        } else if txtAmount.text!.isEmpty {
            self.showError(message: "please_enter_amount".localized)
            return false
        } else if !verifyNumber(number: codeLbl.text! + txtPhoneNumber.text!) {
            showError(message: "invalid_number".localized)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolTitlelbl.text = "wallet_transfer".localized
        pageTitlelbl.text = "request_money_from_wallet".localized
        mobileLbl.text = "mobile_number".localized
        amountlbl.text = "single_amount_txt".localized
        descriptionlbl.text = "description_txt_optional".localized
        btnRequestMoney.setTitle("request_money".localized, for: .normal)
        txtAmount.placeholder = "0.00".localized
        txtDescription.placeholder = "wallet_des_hint".localized
        txtPhoneNumber.placeholder = "phone_number_hint".localized
        
        txtAmount.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        txtAmount.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        flagIcon.makeImageCircle()
        btnRequestMoney.layer.cornerRadius = 8
        
        let viewCodeGesture = UITapGestureRecognizer(target: self, action: #selector(showCountriesFunc(_:)))
        viewCode.addGestureRecognizer(viewCodeGesture)
    }
    
    @objc func showCountriesFunc(_ sender: UITapGestureRecognizer) {
        let nextVC = ControllerID.selectCountryVC.instance
        (nextVC as! SelectCountryVC).codeShown = true
        (nextVC as! SelectCountryVC).countryProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    
    @IBAction func btnRequestFunc(_ sender: UIButton) {
        if preferenceHelper.getISKYCApproved() {
            if isValidate() {
                if Network.isConnectedToNetwork() {
                    self.showProgress()
                    let request = RequestMoney()
                    request.amount = Double(txtAmount.text!)!
                    request.customerNo = preferenceHelper.getCustomerNo()
                    request.description = txtDescription.text!
                    request.mobileNo = String().removePlus(number: codeLbl.text!+txtPhoneNumber.text!)
                    moneyRepo.requestMoney(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_REQUEST_MONEY), completion: {(response , error) in
                        self.hideProgress()
                        if let error = error {
                            self.showError(message: error)
                        } else if response!.responseCode == 101 {
                            self.showAlert(title: "request_money".localized, message: "request_money_message".localized , hidebtn: true)
                        } else {
                            self.showError(message: response!.description!)
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        codeLbl.text = country.countryCode
    }
    
   
}
