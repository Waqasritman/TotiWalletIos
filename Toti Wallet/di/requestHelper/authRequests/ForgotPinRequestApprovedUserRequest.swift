//
//  ForgotPinRequestApprovedUserRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
public class ForgotPinRequestApprovedUserRequest {
    var emailAddress = ""
    var mobileNumber = ""
    var idNumber = ""
    var idExpireDate = ""
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = StaticHelper.ENVELOP_OPENER
            + StaticHelper.HEADER_EMPTY +
            StaticHelper.BODY_OPEN +
            "<tpay:ForgetPIN>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Email_Address>" + emailAddress + "</tpay:Email_Address>" +
            "<tpay:Mobile_Number>" + mobileNumber + "</tpay:Mobile_Number>" +
            "<tpay:ID_Number>" + idNumber + "</tpay:ID_Number>" +
            "<tpay:IDExpiry_Date>" + idExpireDate + "</tpay:IDExpiry_Date>" +
            "</tpay:Req>" +
            "</tpay:ForgetPIN>" +
            StaticHelper.BODY_CLOSE +
            StaticHelper.ENVELOP_CLOSER
        
        return stringParams
    }
}
