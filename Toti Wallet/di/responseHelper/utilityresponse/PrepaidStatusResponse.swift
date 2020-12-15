//
//  PrepaidStatusResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class PrepaidStatusResponse: XMLMappable {
    required init?(map: XMLMap) { }
    
    init() {}
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var statusMessage:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.WRPrepaidStatusResponse.WRPrepaidStatusResult.ResponseCode"]
        description <- map["s:Body.WRPrepaidStatusResponse.WRPrepaidStatusResult.Description"]
        statusMessage <- map["s:Body.WRPrepaidStatusResponse.WRPrepaidStatusResult.statusMessage"]
    }
    
}
