//
//  WalletBalanceResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class WalletBalanceResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    init() {
        
    }
    var walletBalance:String!
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.WalletBalanceResponse.WalletBalanceResult.ResponseCode"]
        description <- map["s:Body.WalletBalanceResponse.WalletBalanceResult.Description"]
        walletBalance <- map["s:Body.WalletBalanceResponse.WalletBalanceResult.WalletBalance"]
    }
}
