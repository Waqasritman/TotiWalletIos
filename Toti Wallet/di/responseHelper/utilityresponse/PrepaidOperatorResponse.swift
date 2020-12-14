//
//  PrepaidOperatorResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class PrepaidOperatorResponse: XMLMappable {
    required init?(map: XMLMap) { }
    init() {}
    
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var operatorCode:String?
    var operatorName:String?
    var circleCode = "";
    var circleName = "";
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.ResponseCode"]
        description <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.Description"]
        operatorCode <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.operatorCode"]
        operatorName <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.operatorName"]
        circleCode <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.circleCode"]
        circleName <- map["s:Body.GetWRPrepaidOperatorResponse.GetWRPrepaidOperatorResult.circleName"]
    }
    
    
}
