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
    
    var beneficiaryList : [BeneficiaryList] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnAddBeneficary.layer.cornerRadius = 8
        
        btnAddBeneficary.isHidden = true
        getBeneficiary()
    }
    

    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getBeneficiary() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let beneRequest = BeneficiaryListRequest()
            beneRequest.customerNo = preferenceHelper.getCustomerNo()
            beneRequest.languageId = preferenceHelper.getLanguage()
        
            beneRepository.getBeneficiaryList(request: HTTPConnection.openConnection(stringParams: beneRequest.getXML(), action: SoapActionHelper.shared.ACTION_GET_BENEFICIARY_LIST), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.beneficiaryList.removeAll()
                    self.beneficiaryList.append(contentsOf: response!.beneficiaryList!)
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
        cell.lblSubtitle.text = "Account no " + beneficiaryList[indexPath.row].accountNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
