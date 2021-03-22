//
//  AppVersionResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 3/11/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
/**
 Program Will help to handle the response of Confirmation Apis  / POST api
 */
class AppVersionResponse: Codable {
    let ResponseCode:Int
    let Description: String
    let Version:String
    
    init(ResponseCode: Int, Description: String , Version:String) {
        self.ResponseCode = ResponseCode
        self.Description = Description
        self.Version = Version
    }
    
    enum CodingKeys: String, CodingKey {
        case ResponseCode = "ResponseCode"
        case Description = "Description"
        case Version  = "Version"
    }
    
}
