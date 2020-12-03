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
    var nodeName: String!
    var walletCurrencyList:[RecCurrency]!
    var responseCode:String!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.ResponseCode"]
        description <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.Description"]
        walletCurrencyList <- map["s:Body.GetWalletCurrencyListResponse.GetWalletCurrencyListResult.obj.diffgr:diffgram.DocumentElement.CurrencyList"]
    }
}
