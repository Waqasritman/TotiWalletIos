//
//  SimpleResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
/**
 Program Will help to handle the response of Confirmation Apis  / POST api
 */
class SimpleResponse: Codable {
    let ResponseCode, Description: String
    
    init(ResponseCode: String, Description: String) {
        self.ResponseCode = ResponseCode
        self.Description = Description
    }
    
    enum CodingKeys: String, CodingKey {
        case ResponseCode = "ResponseCode"
        case Description = "Description"
    }
    
}
