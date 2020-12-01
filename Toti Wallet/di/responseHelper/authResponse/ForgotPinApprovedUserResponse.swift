//
//  ForgotPinApprovedUserResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class ForgotPinApprovedUserResponse :XMLMappable{
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.ForgetPINResponse.ForgetPINResult.ResponseCode"]
        description <- map["s:Body.ForgetPINResponse.ForgetPINResult.Description"]
    }
}
