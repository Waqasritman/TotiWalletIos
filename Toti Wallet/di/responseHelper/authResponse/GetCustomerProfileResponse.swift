//
//  GetCustomerProfileResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/30/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetCustomerProfileResponse:XMLMappable  {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.LoginResponse.LoginResult.ResponseCode"]
        description <- map["s:Body.LoginResponse.LoginResult.Description"]
    }
    
    
}
