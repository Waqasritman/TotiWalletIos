//
//  BeneficiaryListVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BeneficiaryListVC: BaseVC {
    
    let beneRepository:BeneficiaryRespository = BeneficiaryRespository()
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.delegate = self
            listTableView.dataSource = self
        }
    }
    @IBOutlet weak var notFoundView: UIView!
    @IBOutlet weak var btnAddBeneficary: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var searchtxtField: UITextField!
    
    
    var isFromBankTransfer = false
    var isFromCashTransfer = false
    
    
    var list:[BeneficiaryList] = []
    var beneficiaryList : [BeneficiaryList] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchtxtField.delegate = self
        btnAddBeneficary.layer.cornerRadius = 8
        if isFromBankTransfer || isFromCashTransfer {
            btnAddBeneficary.isHidden = false
        } else {
            btnAddBeneficary.isHidden = true
        }
        
        pageTitle.text = "select_beneficairy".localized
        searchtxtField.placeholder = "search".localized
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getBeneficiary()
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnAddBeneficary(_ sender:Any) {
        if isFromBankTransfer {
            let nextVC = ControllerID.addBankBeneficiaryVC.instance
            self.pushWithFullScreen(nextVC)
        } else if isFromCashTransfer {
            let nextVC = ControllerID.cashBeneficaryVC.instance
            self.pushWithFullScreen(nextVC)
        }
     
    }
    
    func getBeneficiary() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let beneRequest = BeneficiaryListRequest()
            beneRequest.customerNo = preferenceHelper.getCustomerNo()
            beneRequest.languageId = preferenceHelper.getApiLangugae()
        
            beneRepository.getBeneficiaryList(request: HTTPConnection.openConnection(stringParams: beneRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_BENEFICIARY_LIST), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.beneficiaryList.removeAll()
                    if self.isFromCashTransfer {
                        self.list.append(contentsOf: BeneficiaryParser.getCashBene(list: response!.beneficiaryList!))
                        self.beneficiaryList.append(contentsOf: BeneficiaryParser.getCashBene(list: response!.beneficiaryList!))
                    } else if self.isFromBankTransfer {
                        self.list.append(contentsOf: BeneficiaryParser.getCashBene(list: response!.beneficiaryList!))
                        self.beneficiaryList.append(contentsOf: BeneficiaryParser.getBankBene(list: response!.beneficiaryList!))
                    } else {
                        self.list.append(contentsOf: BeneficiaryParser.getCashBene(list: response!.beneficiaryList!))
                        self.beneficiaryList.append(contentsOf: response!.beneficiaryList!)
                    }
                   
                    self.listTableView.reloadData()
                } else {
                    self.showError(message: response!.description!)
                }
            })
            
        } else {
            self.noInternet()
        }
    }

}

//MARK : TableView Functions
extension BeneficiaryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if beneficiaryList.isEmpty {
            tableView.isHidden = true
            notFoundView.isHidden = false
        }
        else{
            tableView.isHidden = false
            notFoundView.isHidden = true
        }
        return beneficiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficaryTableCell") as! BeneficaryTableCell
        cell.mainView.layer.cornerRadius = 8
        cell.lblTitle.text = beneficiaryList[indexPath.row].firstName
        if beneficiaryList[indexPath.row].paymentMode.lowercased() == "bank" {
            cell.lblSubtitle.text = "Account no " + beneficiaryList[indexPath.row].accountNumber
        } else if isFromCashTransfer {
            cell.lblSubtitle.text = "Contact no " + beneficiaryList[indexPath.row].telephone
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromBankTransfer {
            let nextVC = ControllerID.bankTransferConverterVC.instance
            (nextVC as! BankTransferConverterVC).beneDetails = beneficiaryList[indexPath.row]
            self.pushWithFullScreen(nextVC)
    
        }
        else if isFromCashTransfer{
            let nextVC = ControllerID.bankTransferConverterVC.instance
            (nextVC as! BankTransferConverterVC).beneDetails = beneficiaryList[indexPath.row]
            self.pushWithFullScreen(nextVC)
      
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension BeneficiaryListVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let string1 = string
        let string2 = searchtxtField.text!
        var finalString = ""
        
        if string.count > 0 { // if it was not delete character
            finalString = string2 + string1
        }
        else if string2.count > 0{ // if it was a delete character
            
            finalString = String(string2.dropLast())
        }
        
        beneficiaryList.removeAll()
        beneficiaryList = list.filter { $0.firstName.lowercased().hasPrefix(finalString.lowercased())}
        
        listTableView.reloadData()
        return true
    }
    
}
