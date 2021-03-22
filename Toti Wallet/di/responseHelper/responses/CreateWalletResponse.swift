//
//  CreateWalletResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/21/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class CreateWalletResponse:XMLMappable {
    required init?(map: XMLMap) {}
    
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.CreateWalletResponse.CreateWalletResult.ResponseCode"]
        description <- map["s:Body.CreateWalletResponse.CreateWalletResult.Description"]
    }
    
    init() {}
}
