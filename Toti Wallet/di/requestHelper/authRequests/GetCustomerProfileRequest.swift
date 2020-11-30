//
//  GetCustomerProfileRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetCustomerProfileRequest {
    var customerNo = ""
    var mobileNo = ""
    var emailAddress = ""
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = StaticHelper.ENVELOP_OPENER
            + StaticHelper.HEADER_EMPTY +
            StaticHelper.BODY_OPEN +
            "<tpay:GetCustomerProfile>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNo>" + customerNo + "</tpay:CustomerNo>" +
            "<tpay:MobileNo>" + mobileNo + "</tpay:MobileNo>" +
            "<tpay:Email_Address>" + emailAddress + "</tpay:Email_Address>" +
            "</tpay:Req>" +
            "</tpay:GetCustomerProfile>" +
            StaticHelper.BODY_CLOSE +
            StaticHelper.ENVELOP_CLOSER
        
        return stringParams
    }
}
