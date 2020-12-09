//
//  EditCustomerProfileResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/9/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class EditCustomerProfileResponse: XMLMappable {
    required init?(map: XMLMap) {
            
    }
    init() {
        
    }
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.EditCustomerProfileResponse.EditCustomerProfileResult.ResponseCode"]
        description <- map["s:Body.EditCustomerProfileResponse.EditCustomerProfileResult.Description"]
    }
}
