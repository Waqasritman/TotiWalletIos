//
//  CountryListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation

import XMLMapper
class CountryListResponse: XMLMappable {
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var wrCountryList:[WRCountryList]?
    var responseCode:Int?
    var description:String?
    
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCountryListResponse.GetCountryListResult.ResponseCode"]
        description <- map["s:Body.GetCountryListResponse.GetCountryListResult.Description"]
        wrCountryList <- map["s:Body.GetCountryListResponse.GetCountryListResult.obj.diffgr:diffgram.GetCountryList"]
    }
}




class WRCountryList: XMLMappable {
    required init?(map: XMLMap) {}
    
    var nodeName: String!
    
    var countryCode:String?
    var countryType:String?
    var countryName:String?
    var countryCurrency:String?
    var currencyShortName:String?
    var countryAbbrevation:String?
    var isdCode:String?
    var url:String?
    
    func mapping(map: XMLMap) {
        countryCode <- map["Country_Code"]
        countryType <- map["Country_Type"]
        countryName <- map["Country_Name"]
        countryCurrency <- map["Country_Currency"]
        currencyShortName <- map["Country_ShortName"]
        isdCode <- map["ISDCode"]
        url <- map["URL"]
    }
}
