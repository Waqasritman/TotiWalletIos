//
//  CashBeneficaryAddressVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 04/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CashBeneficaryAddressVC: BaseVC {
    let repo:BeneficiaryRespository = BeneficiaryRespository()
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var btnAgent: UIButton!
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    
    @IBOutlet weak var agentlbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var toolTitle: UILabel!
    
    var netWorkList:[CashNetworks] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCity.layer.cornerRadius = 8
        btnAgent.layer.cornerRadius = 8
        btnAddBeneficiary.layer.cornerRadius = 8
        
        btnAgent.imageEdgeInsets.left = self.view.frame.width - 50
        
        toolTitle.text = "cash_beneficiary".localized
        pageTitle.text = "send_money_via_cash".localized
        citylbl.text = "city".localized
        agentlbl.text = "availiable_agents".localized
        
        txtCity.placeholder = "city_hint".localized
        btnAgent.setTitle("Please_select_agents".localized, for: .normal)
        btnAddBeneficiary.setTitle("add_beneficiary".localized, for: .normal)
        
        
        
        if Network.isConnectedToNetwork() {
            let request = GetCashNetworkListRequest()
            request.countryCode = BeneficiaryAddRequest.shared.PayoutCountryCode
            request.languageId = preferenceHelper.getLanguage()
            showProgress()
 
            repo.getCashNetworkList(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CASH_NETWORK_LIST), completion: { [self](response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    if response!.list?.count == 1 {
                        self.btnAgent.setTitle(response!.list![0].payOutAgent, for: .normal)
                        BeneficiaryAddRequest.shared.PaymentMode = response!.list![0].paymentMode
                        BeneficiaryAddRequest.shared.PayOutBranchCode = response!.list![0].payOutBranchCode
                    }
                    self.netWorkList.removeAll()
                    self.netWorkList.append(contentsOf: response!.list!)
                   
                } else {
                    self.showError(message: response!.description!)
                }
            })
            
        } else {
            self.noInternet()
        }
    }
    
    
    
    @IBAction func btnPayoutAgent(_ sender:UIButton) {
        if netWorkList.count > 1 {
            
        }
    }
    
    @IBAction func btnNextFunc(_ sender: UIButton) {
        if Network.isConnectedToNetwork() {
            showProgress()
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
        }
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: "cancel_tran".localized)
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}
