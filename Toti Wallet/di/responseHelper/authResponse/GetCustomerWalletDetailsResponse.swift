//
//  GetCustomerWalletDetailsResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetCustomerWalletDetailsResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var walletList:[CustomerWalletDetails]!

    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCustWalletDetailsResponse.GetCustWalletDetailsResult.ResponseCode"]
        description <- map["s:Body.GetCustWalletDetailsResponse.GetCustWalletDetailsResult.Description"]
        walletList <- map["s:Body.GetCustWalletDetailsResponse.GetCustWalletDetailsResult.Obj.diffgr:diffgram.DocumentElement.WalletDetails"]
    }
    
    
}
class CustomerWalletDetails: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var currencyId:Int!
    var currencyShortName:String!
    var currencyFullName:String!
    var balance:String = "0.0"
    var imageURL:String = ""
    var walletName:String!
    
    
    func mapping(map: XMLMap) {
        currencyId <- map["CurrencyID"]
        currencyShortName <- map["CurrencyShortName"]
        currencyFullName <- map["CurrencyName"]
        balance <- map["Balance"]
        imageURL <- map["Image_URL"]
    }
}
