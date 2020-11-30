//
//  RegisterUserRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class RegisterUserRequest {
    
    static var shared = RegisterUserRequest()
    
    var phoneNumber:String = ""
    var email:String = ""
    var OTP:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var middleName:String = ""
    var dob:String = ""
    var gender:String = ""
    var country:String = ""
    var city:String = ""
    var address:String = ""
    var nationality:String = ""
    var languageID:String = ""
    
    
    public func getXML() -> String {
        let stringParams : String = StaticHelper.ENVELOP_OPENER
            + StaticHelper.HEADER_EMPTY +
            StaticHelper.BODY_OPEN +
            "<tpay:CustomerRegistration>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:FirstName>" + firstName + "</tpay:FirstName>" +
            "<tpay:MiddleName>" + middleName + "</tpay:MiddleName>" +
            "<tpay:LastName>" + lastName + "</tpay:LastName>" +
            "<tpay:Address>" + address + "</tpay:Address>" +
            "<tpay:Gender>" + gender + "</tpay:Gender>" +
            "<tpay:MobileNumber>" + phoneNumber + "</tpay:MobileNumber>" +
            "<tpay:Nationality>" + nationality + "</tpay:Nationality>" +
            "<tpay:EmailID>" + email + "</tpay:EmailID>" +
            "<tpay:ResidenceCountry>" + country + "</tpay:ResidenceCountry>" +
            "</tpay:Req>" +
            "</tpay:CustomerRegistration>" +
            StaticHelper.BODY_CLOSE +
            StaticHelper.ENVELOP_CLOSER
        
        return stringParams
    }
}
