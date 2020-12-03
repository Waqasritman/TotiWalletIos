//
//  CustomerCardNoResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class CustomerCardNoResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    var cardNo:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCustomerCardNOResponse.GetCustomerCardNOResult.ResponseCode"]
        description <- map["s:Body.GetCustomerCardNOResponse.GetCustomerCardNOResult.Description"]
        cardNo <- map["s:Body.GetCustomerCardNOResponse.GetCustomerCardNOResult.VirtualCardNo"]
    }
}
