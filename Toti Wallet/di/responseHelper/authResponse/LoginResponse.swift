//
//  LoginResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class LoginResponse :XMLMappable{
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    //  var wrCountryList:[WRCountryList]?
    var responseCode:Int?
    var description:String?
    var CustomerNumber:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.LoginResponse.LoginResult.ResponseCode"]
        description <- map["s:Body.LoginResponse.LoginResult.Description"]
        CustomerNumber <- map["s:Body.LoginResponse.LoginResult.CustomerNumber"]
    }
}
