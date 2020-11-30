//
//  MatchPinRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class MatchPinRequest {
    var languageID:String = "1"
    var customerNO:String = ""
    var customerPIN:String = ""
    
    public func getXML() -> String {
         let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
             + "<soapenv:Header/>" +
             "<soapenv:Body>" +
             "<tpay:Login>" +
             "<tpay:Req>" +
             "<tpay:Credentials>" +
             "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
             "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
             "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
             "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
             "</tpay:Credentials>" +
             "<tpay:Customer_Number>" + customerNO + "</tpay:Customer_Number>" +
             "<tpay:Custommer_PIN>" + customerPIN + "</tpay:Custommer_PIN>" +
             "</tpay:Req>" +
             "</tpay:Login>" +
             "</soapenv:Body>" +
             "</soapenv:Envelope>"
         
         return stringParams
     }
}
