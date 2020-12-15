//
//  WRPrepaidRechargeResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class WRPrepaidRechargeResponse: XMLMappable {
    required init?(map: XMLMap) { }
    init() {}
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var rechargeId:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.WRPrepaidRechargeResponse.WRPrepaidRechargeResult.ResponseCode"]
        description <- map["s:Body.WRPrepaidRechargeResponse.WRPrepaidRechargeResult.Description"]
        rechargeId <- map["s:Body.WRPrepaidRechargeResponse.WRPrepaidRechargeResult.RechargeId"]
    }
}
