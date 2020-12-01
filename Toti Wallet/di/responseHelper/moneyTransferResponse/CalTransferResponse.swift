//
//  CalTransferResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class CalTransferResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var exchangeRate = 0.0
    var commission = 0.0
    var payInCurrency = ""
    var payOutCurrency = ""
    var payInAmount = 0.0
    var payoutAmount = 0.0
    var totalPayable = 0.0
    var vatValue = 0.0
    var vatPercentage = 0.0
    var recommendedAgent = 0
    var payoutBranchCode = 0
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.CalTransferResponse.CalTransferResult.ResponseCode"]
        description <- map["s:Body.CalTransferResponse.CalTransferResult.Description"]
        exchangeRate <- map["s:Body.CalTransferResponse.CalTransferResult.ExchangeRate"]
        vatValue <- map["s:Body.CalTransferResponse.CalTransferResult.VATValue"]
        payInAmount <- map["s:Body.CalTransferResponse.CalTransferResult.PayInAmount"]
        payoutAmount <- map["s:Body.CalTransferResponse.CalTransferResult.PayoutAmount"]
        recommendedAgent <- map["s:Body.CalTransferResponse.CalTransferResult.RecommendAgent"]
        commission <- map["s:Body.CalTransferResponse.CalTransferResult.Commission"]
        totalPayable <- map["s:Body.CalTransferResponse.CalTransferResult.TotalPayable"]
        vatPercentage <- map["s:Body.CalTransferResponse.CalTransferResult.VATPercentage"]
        payoutBranchCode <- map["s:Body.CalTransferResponse.CalTransferResult.PayoutBranchCode"]
        payInCurrency <- map["s:Body.CalTransferResponse.CalTransferResult.PayInCurrency"]
        payOutCurrency <- map["s:Body.CalTransferResponse.CalTransferResult.PayoutCurrency"]
        
    }
    
    
}
