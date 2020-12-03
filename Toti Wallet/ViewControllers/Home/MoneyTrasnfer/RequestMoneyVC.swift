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
    
    
    
    override func isValidate() -> Bool {
        
        if codeLbl.text!.isEmpty {
            self.showError(message: "select country")
            return false
        } else if txtPhoneNumber.text!.isEmpty {
            self.showError(message: "enter number")
            return false
        } else if txtAmount.text!.isEmpty {
            self.showError(message: "enter amount")
            return false
        } else if !verifyNumber(number: codeLbl.text! + txtPhoneNumber.text!) {
            showError(message: "Enter Number Is Invalid")
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        txtAmount.layer.cornerRadius = 8
        txtDescription.layer.cornerRadius = 8
        
        txtPhoneNumber.setLeftPaddingPoints(5)
        txtAmount.setLeftPaddingPoints(10)
        txtDescription.setLeftPaddingPoints(10)
        
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
                        self.showAlert(title: "Request money", message: "Request sent successfully")
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            }

        }
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func onSelectCountry(country: WRCountryList) {
        codeLbl.text = country.countryCode
    }
    
    
    override func handleAction(action: Bool) {
        if action {
            self.navigationController?.popToViewController(ControllerID.tabbar.instance, animated: true)
           // let nextVC = ControllerID.tabbar.instance
           // self.pushWithFullScreen(nextVC)
        }
    }
}
