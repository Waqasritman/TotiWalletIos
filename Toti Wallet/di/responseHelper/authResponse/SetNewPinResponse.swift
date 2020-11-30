//
//  SetNewPinResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class SetNewPinResponse: XMLMappable {
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    //  var wrCountryList:[WRCountryList]?
    var responseCode:Int?
    var description:String?
   
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.SetNewPINResponse.SetNewPINResult.ResponseCode"]
        description <- map["s:Body.SetNewPINResponse.SetNewPINResult.Description"]
      
    }
}
