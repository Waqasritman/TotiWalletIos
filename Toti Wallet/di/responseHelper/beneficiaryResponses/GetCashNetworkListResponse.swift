//
//  GetCashNetworkListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class GetCashNetworkListResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var beneficiaryList:[BeneficiaryList]?
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCashNetworkListResponse.GetCashNetworkListResult.ResponseCode"]
        description <- map["s:Body.GetCashNetworkListResponse.GetCashNetworkListResult.Description"]
        beneficiaryList <- map["s:Body.GetCashNetworkListResponse.GetCashNetworkListResult.obj.diffgr:diffgram.CashNetworkList.tblCashNetworkList"]
    }
    
    
}
class CashNetworks: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    
    func mapping(map: XMLMap) {
        payOutAgent <- map["PayOutAgent"]
        country <- map["Country"]
        countryCode <- map["CountryCode"]
        payOutBranchCode <- map["PayOutBranchCode"]
        payOutCurrencyCode <- map["PayOutCurrencyCode"]
        paymentMode <- map["PaymentMode"]
        city <- map["City"]
        location <- map["Location"]
        branchName <- map["BranchName"]
        address <- map["Address"]
        telephone <- map["Telephone"]
    }
    
    var payOutAgent = ""
    var country = ""
    var countryCode = ""
    var payOutBranchCode = ""
    var payOutCurrencyCode = ""
    var paymentMode = ""
    var city = ""
    var location = ""
    var branchName = ""
    var address = ""
    var telephone = ""
}
