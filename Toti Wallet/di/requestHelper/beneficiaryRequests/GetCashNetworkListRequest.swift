//
//  GetCashNetworkListRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetCashNetworkListRequest {
    var countryCode = "";
    var payoutBankName = "";
    var payoutBranch = "";
    var languageId = "1";
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetCashNetworkList>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CountryCode>" + countryCode + "</tpay:CountryCode>" +
            "<tpay:PayOutBankName>" + payoutBankName + "</tpay:PayOutBankName>" +
            "<tpay:PayOutBranch>" + payoutBranch + "</tpay:PayOutBranch>" +
            "</tpay:Req>" +
            "</tpay:GetCashNetworkList>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
