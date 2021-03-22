//
//  PayoutCurrencyResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/9/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class PayoutCurrencyResponse: XMLMappable {
    required init?(map: XMLMap) {}
    init() {
        
    }
    var nodeName: String!
    var walletCurrencyList:[RecCurrency]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.APIGetPayOutCurrencyListResponse.APIGetPayOutCurrencyListResult.ResponseCode"]
        description <- map["s:Body.APIGetPayOutCurrencyListResponse.APIGetPayOutCurrencyListResult.Description"]
        walletCurrencyList <- map["s:Body.APIGetPayOutCurrencyListResponse.APIGetPayOutCurrencyListResult.obj.diffgr:diffgram.GetPayOutCurrencyList.TblGetPayOutCurrencyList"]
    }
}
