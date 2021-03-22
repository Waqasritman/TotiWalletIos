//
//  CountryTrackResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/21/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class CountryTrackResponse: Codable {

    let ip, country_name: String
   
    enum CodingKeys: String, CodingKey {
        case ip = "ip"
        case country_name = "country_name"
          
    }
    
    init(ip: String, country_name: String) {
        self.ip = ip
        self.country_name = country_name
    }
    
}
