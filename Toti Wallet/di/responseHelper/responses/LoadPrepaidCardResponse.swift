//
//  LoadPrepaidCardResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class LoadPrepaidCardResponse: XMLMappable {
    required init?(map: XMLMap) { }
    init() { }
    
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.LoadVirtualCardResponse.LoadVirtualCardResult.ResponseCode"]
        description <- map["s:Body.LoadVirtualCardResponse.LoadVirtualCardResult.Description"]
    }
}
