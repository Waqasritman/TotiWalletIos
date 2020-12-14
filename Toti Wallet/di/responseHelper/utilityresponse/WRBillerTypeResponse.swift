//
//  WRBillerTypeResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class WRBillerTypeResponse: XMLMappable {
    required init?(map: XMLMap) { }
    init() {}
 
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var countriesList:[WRBillerType]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWRBillerTypeMobileTopUpResponse.GetWRBillerTypeMobileTopUpResult.ResponseCode"]
        description <- map["s:Body.GetWRBillerTypeMobileTopUpResponse.GetWRBillerTypeMobileTopUpResult.Description"]
        countriesList <- map["s:Body.GetWRBillerTypeMobileTopUpResponse.GetWRBillerTypeMobileTopUpResult.obj.diffgr:diffgram.GetWRBillerType.WRBillerType"]
    }
}
class WRBillerType: XMLMappable {
    required init?(map: XMLMap) {}
    
    var nodeName: String!
    var id = ""
    var billerName = ""
    var imageURL = "https://183.87.134.37/IconsImages/Mobile Recharge.png"
    func mapping(map: XMLMap) {
        id <- map["ID"]
        billerName <- map["Name"]
        //imageURL <- map["Currency_ShortName"]
    }
    
    
}
