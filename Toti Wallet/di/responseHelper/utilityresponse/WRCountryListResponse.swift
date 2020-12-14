//
//  WRCountryListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class WRCountryListResponse: XMLMappable {
    
    required init?(map: XMLMap) {}
    init() { }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var countriesList:[WRCountry]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWRCountryListResponse.GetWRCountryListResult.ResponseCode"]
        description <- map["s:Body.GetWRCountryListResponse.GetWRCountryListResult.Description"]
        countriesList <- map["s:Body.GetWRCountryListResponse.GetWRCountryListResult.obj.diffgr:diffgram.GetWRCountryList.WRCountryList"]
    }
}
class WRCountry: XMLMappable {
    
    required init?(map: XMLMap) {}
    
    var nodeName: String!
    var countryShortName = ""
    var countryName = ""
    var countryCurrency = ""
    var countryCode = ""
    var image_URL = ""
    func mapping(map: XMLMap) {
        countryShortName <- map["Country_Code"]
        countryName <- map["Country_Name"]
        countryCurrency <- map["Currency_ShortName"]
        countryCode <- map["ISDCode"]
        image_URL <- map["URL"]
    }
    
    
}
