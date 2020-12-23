//
//  GetCountryListRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetCountryListRequest {
    static let shared = GetCountryListRequest()
    var languageId:String = preferenceHelper.getApiLangugae()
    
    public func getXML() -> String {
         let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
             + "<soapenv:Header/>" +
             "<soapenv:Body>" +
             "<tpay:GetCountryList>" +
             "<tpay:Req>" +
             "<tpay:Credentials>" +
             "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
             "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
             "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
             "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
             "</tpay:Credentials>" +
             "</tpay:Req>" +
             "</tpay:GetCountryList>" +
             "</soapenv:Body>" +
             "</soapenv:Envelope>"
         
         return stringParams
     }
}
