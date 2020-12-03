//
//  WalletCurrencyListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class WalletCurrencyListResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    var nodeName: String!
    var walletCurrencyList:[RecCurrency]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.ResponseCode"]
        description <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.Description"]
        walletCurrencyList <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.Obj.diffgr:diffgram.DocumentElement.CurrencyList"]
    }
}
