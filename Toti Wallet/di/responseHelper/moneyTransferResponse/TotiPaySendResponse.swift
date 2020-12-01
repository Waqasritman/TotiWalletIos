//
//  TotiPaySendResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class TotiPaySendResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var transactionNo:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.TotiPaySendResponse.TotiPaySendResult.ResponseCode"]
        description <- map["s:Body.TotiPaySendResponse.TotiPaySendResult.Description"]
        transactionNo <- map["s:Body.TotiPaySendResponse.TotiPaySendResult.TransactionNumber"]
    }
    
    
}
