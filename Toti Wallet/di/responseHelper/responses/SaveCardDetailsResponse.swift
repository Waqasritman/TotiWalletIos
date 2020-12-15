//
//  SaveCardDetailsResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class SaveCardDetailsResponse: XMLMappable {
    required init?(map: XMLMap) {}
    init() {}
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.SaveCardDetailsResponse.SaveCardDetailsResult.ResponseCode"]
        description <- map["s:Body.SaveCardDetailsResponse.SaveCardDetailsResult.Description"]
       
    }
}
