//
//  YLocationResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class YLocationResponse: XMLMappable {
    required init?(map: XMLMap) {
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var list:[YLocations]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetYLocationResponse.GetYLocationResult.ResponseCode"]
        description <- map["s:Body.GetYLocationResponse.GetYLocationResult.Description"]
        list <- map["s:Body.GetYLocationResponse.GetYLocationResult.obj.diffgr:diffgram.NewDataSet.Table1"]
    }
}
class YLocations: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var locationId:Int!
    var locationName:String!
    
    func mapping(map: XMLMap) {
        locationId <- map["Location_ID"]
        locationName <- map["Location_Name"]
    }
    
}
