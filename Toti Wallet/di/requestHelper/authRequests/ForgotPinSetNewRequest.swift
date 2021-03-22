//
//  ForgotPinSetNewRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class ForgotPinSetNewRequest {
    var emailAddress:String = ""
    var mobileNumber:String  = ""
    var newPin:String = ""
    var confirmPin:String = ""
    var languageId:String  = "1"
    
    
    public func getXML() -> String {
         let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
             + "<soapenv:Header/>" +
             "<soapenv:Body>" +
             "<tpay:SetNewPIN>" +
             "<tpay:Req>" +
             "<tpay:Credentials>" +
             "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
             "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
             "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
             "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
             "</tpay:Credentials>" +
             "<tpay:Email_Address>" + emailAddress + "</tpay:Email_Address>" +
            "<tpay:Mobile_Number>" + mobileNumber.removeWhitespace() + "</tpay:Mobile_Number>" +
             "<tpay:New_PIN>" + newPin + "</tpay:New_PIN>" +
            "<tpay:Confirm_PIN>" + confirmPin + "</tpay:Confirm_PIN>" +
             "</tpay:Req>" +
             "</tpay:SetNewPIN>" +
             "</soapenv:Body>" +
             "</soapenv:Envelope>"
         
         return stringParams
     }
}
