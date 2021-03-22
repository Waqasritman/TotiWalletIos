//
//  BankDepositDetailsNamesRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 2/15/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class BankDepositDetailsNamesRequest {
    var currencyShortName = ""
    var langugaeID = "1"
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetTotiPayAccDetails>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + langugaeID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CountryShortName>" + currencyShortName + "</tpay:CountryShortName>" +
            "</tpay:Req>" +
            "</tpay:GetTotiPayAccDetails>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    
    }
}
