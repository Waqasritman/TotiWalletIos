//
//  B2BTransferResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/16/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class B2BTransferResponse: XMLMappable {
    required init?(map: XMLMap) {}
    init() {}
    
    var responseCode:Int!
    var description:String!
    var nodeName: String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.B2BTransferDetailsResponse.B2BTransferDetailsResult.ResponseCode"]
        description <- map["s:Body.B2BTransferDetailsResponse.B2BTransferDetailsResult.Description"]
    }
}
