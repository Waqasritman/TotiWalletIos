//
//  AppVersionRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 3/11/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class AppVersionRequest {
    var credentials = Credentials()
    func toJSON() -> [String:Any] {
        return ["Credentials" : credentials.toJSON() , "DeviceType" :"IOS" ]
    }
}
