//
//  GetSendRecCurrencyResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetSendRecCurrencyResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var currencyList:[RecCurrency]!
    var responseCode:String!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetSendRecCurrencyResponse.GetSendRecCurrencyResult.ResponseCode"]
        description <- map["s:Body.GetSendRecCurrencyResponse.GetSendRecCurrencyResult.Description"]
        currencyList <- map["s:Body.GetSendRecCurrencyResponse.GetSendRecCurrencyResult.obj.diffgr:diffgram.GetSendRecCurrency.tblGetSendRecCurrency"]
    }
    
}

class RecCurrency: XMLMappable {
    
    
    required init?(map: XMLMap) {
        
    }
    var id:String!
    var currencyName:String!
    var currencyShortName:String!
    var image_URL:String!
    var nodeName: String!
    
    func mapping(map: XMLMap) {
        id <- map["Currency_Id"]
        currencyName <- map["CurrencyName"]
        currencyShortName <- map["CurrencyShortName"]
        image_URL <- map["Image_URL"]
    }
}
