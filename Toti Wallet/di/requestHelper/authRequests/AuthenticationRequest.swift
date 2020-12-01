//
//  AuthenticationRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
public class AuthenticationRequest {
    var mobileNumber:String = ""
    var email:String = ""
    var languageID = "1"
    
    
    public func getXML() -> String {
         return  "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
             + "<soapenv:Header/>" +
             "<soapenv:Body>" +
             "<tpay:Authentication>" +
             "<tpay:Req>" +
             "<tpay:Credentials>" +
             "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
             "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
             "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
             "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
             "</tpay:Credentials>" +
             "<tpay:Email_Address>" + email + "</tpay:Email_Address>" +
             "<tpay:Mobile_Number>" + mobileNumber + "</tpay:Mobile_Number>" +
             "</tpay:Req>" +
             "</tpay:Authentication>" +
             "</soapenv:Body>" +
             "</soapenv:Envelope>"
         
     }
}
