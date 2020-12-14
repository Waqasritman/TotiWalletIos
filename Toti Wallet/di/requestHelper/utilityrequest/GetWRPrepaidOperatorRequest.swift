//
//  GetWRPrepaidOperatorRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetWRPrepaidOperatorRequest {
    var countryShortName = ""
    var mobileNo = ""
    var languageId = ""
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetWRPrepaidOperator>" +
                           "<tpay:Req>" +
                           "<tpay:Credentials>" +
                           "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
                           "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
                           "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
                           "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
                           "</tpay:Credentials>" +
                           "<tpay:CountryCode>" + countryShortName + "</tpay:CountryCode>" +
                           "<tpay:MobileNo>" + mobileNo + "</tpay:MobileNo>" +
                           "</tpay:Req>" +
                           "</tpay:GetWRPrepaidOperator>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
