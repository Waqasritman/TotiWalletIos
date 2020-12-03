//
//  GetCustomerProfileImageRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetCustomerProfileImageRequest {
    //let credentials:Credentials = Credentials()
    var Customer_No:String = ""
    var langugaeID:String = "1"
    
    
    func toJSON() -> [String:Any]{
        return ["Customer_No" :Customer_No,"PartnerCode" : StaticHelper.PARTNER_CODE_VALUE , "UserName" :StaticHelper.USER_NAME_VALUE , "UserPassword": StaticHelper.USER_PASSWORD_VALUE ,"LanguageID" : langugaeID]
    }
    
}
