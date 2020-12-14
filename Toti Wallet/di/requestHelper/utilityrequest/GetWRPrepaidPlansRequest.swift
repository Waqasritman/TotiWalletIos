//
//  GetWRPrepaidPlansRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetWRPrepaidPlansRequest {
    static let shared = GetWRPrepaidPlansRequest()
    var countryCode = ""
    var operatorCode = ""
    var circleCode = ""
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetWRPrepaidPlans>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CountryCode>" + countryCode + "</tpay:CountryCode>" +
            "<tpay:OperatorCode>" + operatorCode + "</tpay:OperatorCode>" +
            "<tpay:CircleCode>" + circleCode + "</tpay:CircleCode>" +
            "</tpay:Req>" +
            "</tpay:GetWRPrepaidPlans>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
