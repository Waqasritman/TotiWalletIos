//
//  MyCardsVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 30/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MyCardsVC: BaseVC {

    let repo:Repository = Repository()
    @IBOutlet weak var viewGooglePay: UIView!
    @IBOutlet weak var viewPaytm: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewGooglePay.layer.cornerRadius = 8
        viewPaytm.layer.cornerRadius = 8
        getCustomerCards()
    }
    
    
    @IBAction func btnLoadCard(_ sender:Any) {
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        (tabBarController as! CustomTabBarController).selectedIndex = 0
    }
    
    
    func getCustomerCards() {
        if Network.isConnectedToNetwork() {
            self.showProgress()
            let request = GetCardDetailsRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageID = preferenceHelper.getLanguage()
            repo.loadCustomerCards(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CARD_DETAILS), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.showSuccess(message: response!.description!)
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    }

}
