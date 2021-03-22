//
//  AppSettingsRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/2/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class AppSettingsRequest {
    var languageID = "1"
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:AppSetting>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "</tpay:Req>" +
            "</tpay:AppSetting>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
