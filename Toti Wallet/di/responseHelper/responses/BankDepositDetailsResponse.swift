//
//  BankDepositDetailsResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 2/15/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class BankDepositDetailsResponse: XMLMappable {
    
    init() {
        
    }
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var dataList:[BankDepositDetails]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetTotiPayAccDetailsResponse.GetTotiPayAccDetailsResult.ResponseCode"]
        description <- map["s:Body.GetTotiPayAccDetailsResponse.GetTotiPayAccDetailsResult.Description"]
        dataList <- map["s:Body.GetTotiPayAccDetailsResponse.GetTotiPayAccDetailsResult.Obj.diffgr:diffgram.DocumentElement.TotiPayAccDetails"]
    }
    
    
}
class BankDepositDetails:XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var data:String!
    func mapping(map: XMLMap) {
        data <- map["Data"]
    }
    
    
}
