//
//  CreateWalletVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/19/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import UIKit

class CreateWalletVC: BaseVC , CurrencyListProtocol {
   
    let repo : Repository = Repository()
    let createWalletRequest = CreateWalletRequest()
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var walletFlagImage: UIImageView!
    @IBOutlet weak var walletCurrencyLbl: UILabel!
    @IBOutlet weak var viewCurrency: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCurrency.layer.cornerRadius = 8
        createBtn.layer.cornerRadius = 8
        
        walletFlagImage.makeImageCircle()
        
        
        pageTitle.text = "create_new_wallet".localized
        createBtn.setTitle("create_wallet".localized, for: .normal)
        
    }
    
    
    override func isValidate() -> Bool {
        if createWalletRequest.walletCurrency.isEmpty {
            self.showError(message: "select_new_wallet".localized)
            return false
        }
        return true
    }
    
    
    @IBAction func onBackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showWalletBtn(_ sender: Any) {
        if Network.isConnectedToNetwork() {
            let request = GetCCYForWalletRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.actionType = CCYWalletActionType.CREATE
            request.languageID = preferenceHelper.getApiLangugae()
            self.showProgress()
            repo.getCCYWallets(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_ADD_CCY_WALLET), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showCurrency(list: response!.walletCurrencyList)
                } else if response!.description != nil {
                    self.showError(message: response!.description)
                } else {
                    self.showError(message: "contact_to_admin".localized)
                }
            })
        }
    }
    
    
    
    func showCurrency(list:[RecCurrency]) {
        let nextVC = ControllerID.selectCurrencyVC.instance
        (nextVC as! SelectCurrencyVC).filteredList = list
        (nextVC as! SelectCurrencyVC).currencyProtocol = self
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func createWalletbtnClick(_ sender: Any) {
        if isValidate() {
            if Network.isConnectedToNetwork() {
                createWalletRequest.customerNo = preferenceHelper.getCustomerNo()
                createWalletRequest.langugaeID = preferenceHelper.getApiLangugae()
                self.showProgress()
                repo.createWallet(request: HTTPConnection.openConnection(stringParams: createWalletRequest.getXML(), action: SoapActionHelper.shared.ACTION_CREATE_WALLET), completion: {(response , error ) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error)
                    } else if response!.responseCode == 101 {
                        self.showSuccess(message: response!.description)
                        preferenceHelper.isWalletNeedToUpdate(isNeed: true)
                        self.navigationController?.popViewController(animated: true)
                    } else if response!.description != nil {
                        self.showError(message: response!.description)
                    } else {
                        self.showError(message: "contact_to_admin".localized)
                    }
                })
            } else {
                self.noInternet()
            }
        }
    }
    
    
    func onSelectCurrency(currency: RecCurrency) {
        self.walletCurrencyLbl.text = currency.currencyShortName
        createWalletRequest.walletCurrency = currency.currencyShortName
        self.walletFlagImage.sd_setImage(with: URL(string: currency.image_URL))
    }
    
    func onCurrencyList(currencyList: [RecCurrency]) {
        
    }
    
}
