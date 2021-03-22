//
//  GetCCYWalletResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/20/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetCCYWalletResponse: XMLMappable {
    
    required init?(map: XMLMap) {}
    init() {}
    var nodeName: String!
    var walletCurrencyList:[RecCurrency]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCCYForWalletResponse.GetCCYForWalletResult.ResponseCode"]
        description <- map["s:Body.GetCCYForWalletResponse.GetCCYForWalletResult.Description"]
        walletCurrencyList <- map["s:Body.GetCCYForWalletResponse.GetCCYForWalletResult.Obj.diffgr:diffgram.DocumentElement.CurrencyList"]
    }
    
}
