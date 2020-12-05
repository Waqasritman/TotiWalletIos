//
//  YCityResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class YCityResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
    }
    
    
    var nodeName: String!
    var list:[YCities]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetYCityResponse.GetYCityResult.ResponseCode"]
        description <- map["s:Body.GetYCityResponse.GetYCityResult.Description"]
        list <- map["s:Body.GetYCityResponse.GetYCityResult.obj.diffgr:diffgram.NewDataSet.Table1"]
    }
    
}
class YCities: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var cityId:Int!
    var cityName:String!
    func mapping(map: XMLMap) {
        cityId <- map["City_ID"]
        cityName <- map["City_Name"]
    }
}
