//
//  CustomerRegistrationResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class CustomerRegistration: XMLMappable {
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var CustomerNumber:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.CustomerRegistrationResponse.CustomerRegistrationResult.ResponseCode"]
        description <- map["s:Body.CustomerRegistrationResponse.CustomerRegistrationResult.Description"]
        CustomerNumber <- map["s:Body.CustomerRegistrationResponse.CustomerRegistrationResult.CustomerNumber"]
    }
}
