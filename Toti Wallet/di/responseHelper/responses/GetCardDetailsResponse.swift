//
//  GetCardDetailsResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetCardDetailsResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var cardDetails:[CardDetails]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCardDetailsResponse.GetCardDetailsResult.ResponseCode"]
        description <- map["s:Body.GetCardDetailsResponse.GetCardDetailsResult.Description"]
        cardDetails <- map["s:Body.GetCardDetailsResponse.GetCardDetailsResult.obj.diffgr:diffgram.DocumentElement.CardDetails"]
    }
    
}

class CardDetails: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var cardNumber:String!
    var cardExpireDate:String!
    var cardName:String!
    func mapping(map: XMLMap) {
        cardNumber <- map["Card_Number"]
        cardExpireDate <- map["CardExpiry_Date"]
        cardName <- map["Customer_CardName"]
    }
    
    
}
