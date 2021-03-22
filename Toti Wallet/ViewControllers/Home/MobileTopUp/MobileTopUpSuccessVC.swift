//
//  MobileTopUpSuccessVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MobileTopUpSuccessVC: BaseVC {

    let repo : UtilityRepository = UtilityRepository()
    
    @IBOutlet weak var operatorNamelbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var statuslbl: UILabel!
    
    var status:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operatorNamelbl.text = WRPrepaidRechargeRequest.shared.operatorName
        amountlbl.text = WRPrepaidRechargeRequest.shared.payOutAmount
            + " " + WRPrepaidRechargeRequest.shared.payoutCurrency
      
        
        
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = PrepaidStatusRequest()
            request.requestId = status
            request.languageId = preferenceHelper.getApiLangugae()
            
            repo.getStatus(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_PREPAID_STATUS), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.statuslbl.text = response!.statusMessage
                } else {
                    self.showError(message: response!.description!)
                }
            })
        }
    
        WRPrepaidRechargeRequest.shared.clearRequest()
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
       gotoHome()
    }
    

}
