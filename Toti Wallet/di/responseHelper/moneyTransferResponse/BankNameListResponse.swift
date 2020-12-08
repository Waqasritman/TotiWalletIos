//
//  BankNameListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/8/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class BankNameListResponse: XMLMappable  {
    required init?(map: XMLMap) {
            
    }
    
    init() {
        
    }
    var bankNames:[BankName]!
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.BankNameListResponse.BankNameListResult.ResponseCode"]
        description <- map["s:Body.BankNameListResponse.BankNameListResult.Description"]
        bankNames <- map["s:Body.BankNameListResponse.BankNameListResult.obj.diffgr:diffgram.DocumentElement.BankList"]
    }

}
class BankName: XMLMappable {
    required init?(map: XMLMap) {
            
    }
    
    init() {
        
    }
    var bankName:String = ""
    var nodeName: String!
    
    
    func mapping(map: XMLMap) {
        bankName <- map["BankName"]
    }
}
