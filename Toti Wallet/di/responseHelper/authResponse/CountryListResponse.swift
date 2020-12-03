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
        wrCountryList <- map["s:Body.GetCountryListResponse.GetCountryListResult.obj.diffgr:diffgram.GetCountryList.tblCountryList"]
    }
}




class WRCountryList: XMLMappable {
    required init?(map: XMLMap) {}
    
    var nodeName: String!
    var countryId:String = ""
    var countryCode:String = ""
    var countryType:Int = 0
    var countryName:String = ""
    var countryCurrency:String = ""
    var currencyShortName:String = ""
    var countryAbbrevation:String = ""
    var countryShortName:String = ""
    var isActive:Bool = false
    var url:String = ""
    var countryOrigin:Int = 0
    
    func mapping(map: XMLMap) {
        countryId <- map["CountryID"]
        countryCode <- map["CountryCode"]
        countryType <- map["CountryType"]
        countryName <- map["CountryName"]
        countryCurrency <- map["Country_Currency"]
        currencyShortName <- map["CurrencyShortName"]
        countryShortName <- map["CountryShortName"]
        isActive <- map["Active"]
        url <- map["Image_URL"]
        countryOrigin <- map["Country_Origine"]
    }
}
