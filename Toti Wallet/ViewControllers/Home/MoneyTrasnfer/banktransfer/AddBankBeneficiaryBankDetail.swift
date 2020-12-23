//
//  AddBankBeneficiaryBankDetail.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddBankBeneficiaryBankDetail: BaseVC , BankNameProtocol , BankNetworkProtocol
 , UITextFieldDelegate{
    

    let repo :BeneficiaryRespository = BeneficiaryRespository()
    let bankNetworkListRequest = GetBankNetworkListRequest()
    @IBOutlet weak var btnBankName: UIButton!
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnBranchName: UIButton!
    @IBOutlet weak var btnAccountNumber: UITextField!
    @IBOutlet weak var btnReEnterAccount: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSearchBranch:UIButton!
    @IBOutlet weak var branchView: UIStackView!
    
    
    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var banklbl: UILabel!
    @IBOutlet weak var citynamelbl: UILabel!
    @IBOutlet weak var branchlbl: UILabel!
    @IBOutlet weak var accountNolbl: UILabel!
    @IBOutlet weak var reenteraccountnolbl: UILabel!
    
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    
    
    var bankName = ""
    var isBankSelected = false
    var isBranchSelected = false
    
    var bankNetworkList:[BankNetwork] = []
    
    override func isValidate() -> Bool {
        if !isBranchSelected {
            self.showError(message: "please_select_bank_error".localized)
            return false
        } else if btnAccountNumber.text!.isEmpty {
            self.showError(message: "enter_account_no_error".localized)
            return false
        } else if btnReEnterAccount.text!.isEmpty {
            self.showError(message: "enter_account_no_error".localized)
            return false
        } else if !btnAccountNumber.text!.elementsEqual(btnReEnterAccount.text!) {
            self.showError(message: "account_no_same_error".localized)
            return false
        }
        return true
    }
    
    
    
    func isValidateForBranch() -> Bool  {
        if bankName.isEmpty {
            return false
        } else if txtCityName.text!.isEmpty {
            return false
        } else if txtLocation.text!.isEmpty  {
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        toolTitle.text = "bank_beneficairy".localized
        pageTitle.text = "enter_bank_details".localized
        banklbl.text = "bank_name".localized
        citynamelbl.text = "city_name_m".localized
        locationlbl.text = "location_txt_m".localized
        btnSearchBranch.setTitle("search_branch".localized, for: .normal)
        
        branchlbl.text = "branch".localized
        accountNolbl.text = "account_no_txt".localized
        reenteraccountnolbl.text = "re_enter_account_no_m".localized
        
        btnBankName.setTitle("select_bank_name".localized, for: .normal)
        txtCityName.placeholder = "enter_city_name".localized
        txtLocation.placeholder = "enter_location".localized
        
        btnBranchName.setTitle("branch_name".localized, for: .normal)
        btnAccountNumber.placeholder = "account_no_hint".localized
        btnReEnterAccount.placeholder = "account_no_hint".localized
        btnAddBeneficiary.setTitle("add_beneficiary".localized, for: .normal)

        btnBankName.layer.cornerRadius = 8
        txtCityName.layer.cornerRadius = 8
        txtLocation.layer.cornerRadius = 8
        btnBranchName.layer.cornerRadius = 8
        btnAccountNumber.layer.cornerRadius = 8
        btnReEnterAccount.layer.cornerRadius = 8
        btnAddBeneficiary.layer.cornerRadius = 8
        btnNext.layer.cornerRadius = 8
        btnSearchBranch.layer.cornerRadius = 8
        
        btnAccountNumber.delegate = self
        btnReEnterAccount.delegate = self
        txtCityName.delegate = self
        txtLocation.delegate = self
        
        txtCityName.setLeftPaddingPoints(10)
        txtLocation.setLeftPaddingPoints(10)
        btnAccountNumber.setLeftPaddingPoints(10)
        btnReEnterAccount.setLeftPaddingPoints(10)
        
        btnBankName.imageEdgeInsets.left = self.view.frame.width - 50
        btnBranchName.imageEdgeInsets.left = self.view.frame.width - 50
    }
    
    
    @IBAction func btnSeachBracnhClick(_ sender:UIButton)  {
        if isValidateForBranch() {
            
            if Network.isConnectedToNetwork() {
                showProgress()
                bankNetworkListRequest.bankName = bankName
                bankNetworkListRequest.countryCode = BeneficiaryAddRequest.shared.PayoutCountryCode
                bankNetworkListRequest.branchName = txtLocation.text!
                bankNetworkListRequest.languageId = preferenceHelper.getLanguage()
                bankNetworkListRequest.city = txtCityName.text!
                
                repo.getBankNetworkList(request: HTTPConnection.openConnection(stringParams: bankNetworkListRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_BANK_NETWORK_LIST), completion: {(response , error) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.bankNetworkList.removeAll()
                        self.bankNetworkList.append(contentsOf: response!.bankNetworkList!)
                        self.branchView.isHidden = false
                        self.btnSearchBranch.isHidden = true
                        self.btnNext.isHidden = false
                        
                        
                    } else {
                        self.showError(message: response!.description!)
                    }
                })
            }
            
          
        }
    }
    
    
    
    @IBAction func btnNextClick(_ sender:UIButton) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                showProgress()
                BeneficiaryAddRequest.shared.customerNo = preferenceHelper.getCustomerNo()
                BeneficiaryAddRequest.shared.Telephone = "1234567890"
                BeneficiaryAddRequest.shared.PaymentMode = "bank"
                BeneficiaryAddRequest.shared.languageId = preferenceHelper.getLanguage()
                BeneficiaryAddRequest.shared.AccountNumber = btnAccountNumber.text!
                
                print(BeneficiaryAddRequest.shared.getXML())
                repo.addBeneficiary(request: HTTPConnection.openConnection(stringParams: BeneficiaryAddRequest.shared.getXML(), action: SoapActionHelper.shared.ACTION_ADD_BENEFICIARY), completion: {(response , error) in
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
    
    
    @IBAction func btnOnBankClick(_ sender:UIButton) {
        let nextVC = ControllerID.bankNamesVC.instance
        (nextVC as! BankNamesVC).payOutCountry = BeneficiaryAddRequest.shared.PayoutCountryCode
        (nextVC as! BankNamesVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }

    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    
    @IBAction func btnBranchfuncClcik(_ sender:UIButton) {
        let nextVC = ControllerID.branchNamesVC.instance
      
        (nextVC as! BranchNamesVC).filteredList = bankNetworkList
        (nextVC as! BranchNamesVC).delegate = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func onSelectBankNetwork(network: BankNetwork) {
        isBranchSelected = true
        btnBranchName.setTitle(network.branchName, for: .normal)
        btnBranchName.setTitleColor(.black, for: .normal)
        BeneficiaryAddRequest.shared.BankCode = network.bankCode
        BeneficiaryAddRequest.shared.BankName = network.bankName
        BeneficiaryAddRequest.shared.BankBranch = network.branchName
        BeneficiaryAddRequest.shared.BranchNameAndAddress = network.bankAddress
        BeneficiaryAddRequest.shared.Address = network.bankAddress
        BeneficiaryAddRequest.shared.BankCountry = BeneficiaryAddRequest.shared.PayoutCountryCode
        BeneficiaryAddRequest.shared.PayOutBranchCode = network.bankCode
    }
    
    
    func onSelectBank(bank: BankName) {
        btnBankName.setTitle(bank.bankName, for: .normal)
        btnBankName.setTitleColor(.black, for: .normal)
        bankName = bank.bankName
        branchView.isHidden = true
        btnSearchBranch.isHidden = false
        btnNext.isHidden = true
        
    }

}
extension AddBankBeneficiaryBankDetail {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
