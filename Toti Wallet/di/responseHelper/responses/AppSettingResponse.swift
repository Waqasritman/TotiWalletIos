//
//  AppSettingResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/2/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class AppSettingResponse: XMLMappable {
    
    required init?(map: XMLMap) { }
    init() {
        
    }
    var nodeName: String!
    var description:String!
    var responseCode: Int!
    var hideData:Bool!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.AppSettingResponse.AppSettingResult.ResponseCode"]
        description <- map["s:Body.AppSettingResponse.AppSettingResult.Description"]
        hideData <- map["s:Body.AppSettingResponse.AppSettingResult.HideData"]
    }
    
    
}
