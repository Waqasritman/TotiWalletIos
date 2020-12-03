//
//  Credentials.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class Credentials {
    let PartnerCode:Int = Int(StaticHelper.PARTNER_CODE_VALUE)!
    let UserName:String = StaticHelper.USER_NAME_VALUE
    let UserPassword:String = StaticHelper.USER_PASSWORD_VALUE
    var LanguageID:Int = 1
    
    
    func toJSON() -> [String:Any] {
        return ["PartnerCode" : PartnerCode , "UserName" :UserName , "UserPassword": UserPassword ,"LanguageID": LanguageID ]
    }
}
