//
//  BankBeneficiaryIndiaVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/13/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BankBeneficiaryIndiaVC: BaseVC , BankNetworkProtocol , UITextFieldDelegate {
   
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var toolTitle: UILabel!
    let addBeneRepo = BeneficiaryRespository()
    @IBOutlet weak var hdfcCodeField:UITextField!
    @IBOutlet weak var accountNoField:UITextField!
    @IBOutlet weak var reEnterAccountNoField:UITextField!
    @IBOutlet weak var hdfcLbl:UILabel!
    @IBOutlet weak var bankNameLbl:UIButton!
    
    @IBOutlet weak var hdfcCodeLbl:UITextField!
    
    @IBOutlet weak var btnSearchBank:UIButton!
    @IBOutlet weak var btnAddBeneficiary:UIButton!
    
    @IBOutlet weak var ifscStack:UIStackView!
    @IBOutlet weak var bankStack:UIStackView!
    
    var bankNetworkList:[BankNetwork] = []
    
    @IBOutlet weak var ifscLbl: UILabel!
    @IBOutlet weak var reEnteraccountlbl: UILabel!
    @IBOutlet weak var accountNolbl: UILabel!
    @IBOutlet weak var bankNamelbl: UILabel!
    
    override func isValidate() -> Bool {
        if accountNoField.text!.isEmpty {
            showError(message: "enter_account_no_error".localized)
            return false
        } else if reEnterAccountNoField.text!.isEmpty {
            showError(message: "enter_account_no_error".localized)
            return false
        } else if !accountNoField.text!.elementsEqual(reEnterAccountNoField.text!) {
            showError(message: "account_no_same_error".localized)
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankStack.isHidden = true
        hdfcCodeField.setLeftPaddingPoints(10)
        accountNoField.setLeftPaddingPoints(10)
        reEnterAccountNoField.setLeftPaddingPoints(10)
        hdfcCodeField.setLeftPaddingPoints(10)
        accountNoField.setLeftPaddingPoints(10)
        hdfcCodeLbl.setLeftPaddingPoints(10)
       
        
        accountNoField.delegate = self
        reEnterAccountNoField.delegate = self
        
        btnSearchBank.layer.cornerRadius = 8
        btnSearchBank.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        
        btnAddBeneficiary.layer.cornerRadius = 8
        btnAddBeneficiary.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        
        bankNameLbl.imageEdgeInsets.left = self.view.frame.width - 50
       
        hdfcCodeField.layer.cornerRadius = 8
        accountNoField.layer.cornerRadius = 8
        reEnterAccountNoField.layer.cornerRadius = 8
        hdfcCodeLbl.layer.cornerRadius = 8
        

        toolTitle.text = "bank_beneficairy".localized
        pageTitle.text = "enter_ifsc_code".localized
        hdfcLbl.text = "ifsc_text".localized
        bankNamelbl.text = "bank_name".localized
        accountNolbl.text = "account_no_txt".localized
        reEnteraccountlbl.text = "re_enter_account_no_m".localized
        ifscLbl.text = "ifsc_code".localized
        
        hdfcCodeField.placeholder = "ifsc_code".localized
        btnSearchBank.setTitle("search_bank".localized, for: .normal)
        bankNameLbl.setTitle("bank_name".localized, for: .normal)
        accountNoField.placeholder = "account_no_hint".localized
        reEnterAccountNoField.placeholder = "account_no_hint".localized
        hdfcCodeLbl.placeholder = "ifsc_code".localized
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnSearchBank(_ sender:Any) {
        if !hdfcCodeField.text!.isEmpty {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = GetBankNetworkListRequest()
                request.countryCode = "ind"
                request.branchIFSC = hdfcCodeField.text!
                request.languageId = preferenceHelper.getLanguage()
                
                addBeneRepo.getBankNetworkList(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_BANK_NETWORK_LIST), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.bankNetworkList.removeAll()
                        self.bankNetworkList.append(contentsOf: response!.bankNetworkList!)
                        
                        if self.bankNetworkList.count == 1 {
                            self.onSelectBankNetwork(network:  self.bankNetworkList[0])
                        }
                        
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                
            }
        } else {
            self.showError(message: "enter_ifsc_code".localized)
        }
    }
    
    
    
    func onSelectBankNetwork(network: BankNetwork) {
        bankNameLbl.setTitle(network.bankName, for: .normal)
        bankNameLbl.setTitleColor(.black, for: .normal)
        ifscStack.isHidden = true
        bankStack.isHidden = false
        hdfcCodeLbl.text = network.bankCode
        btnAddBeneficiary.isHidden = false
        BeneficiaryAddRequest.shared.BankCode = network.bankCode
        BeneficiaryAddRequest.shared.BankName = network.bankName
        BeneficiaryAddRequest.shared.BankBranch = network.branchName
        BeneficiaryAddRequest.shared.BranchNameAndAddress = network.bankAddress
        BeneficiaryAddRequest.shared.Address = network.bankAddress
        BeneficiaryAddRequest.shared.BankCountry = BeneficiaryAddRequest.shared.PayoutCountryCode
        BeneficiaryAddRequest.shared.PayOutBranchCode = network.bankCode
    }
    
    @IBAction func btnAddBeneficairy(_ sender:Any) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                BeneficiaryAddRequest.shared.customerNo = preferenceHelper.getCustomerNo()
                BeneficiaryAddRequest.shared.Telephone = "1234567890"
                BeneficiaryAddRequest.shared.PaymentMode = "bank"
                BeneficiaryAddRequest.shared.languageId = preferenceHelper.getLanguage()
                BeneficiaryAddRequest.shared.AccountNumber = accountNoField.text!
                
                print(BeneficiaryAddRequest.shared.getXML())
                addBeneRepo.addBeneficiary(request: HTTPConnection.openConnection(stringParams: BeneficiaryAddRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_ADD_BENEFICIARY), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description!)
                        for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: BeneficiaryListVC.self) {
                                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            } else {
                self.noInternet()
            }
        }
    }
    
    
    @IBAction func onClossClick(_ sender:Any) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender:Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension BankBeneficiaryIndiaVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
