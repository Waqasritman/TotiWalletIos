//
//  PurposeOfTransferListRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class PurposeOfTransferListRequest {
    var languageId:String = ""
    var shortCountryName:String = ""
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetPurposeOfTransferList>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CountryShortName>" + shortCountryName + "</tpay:CountryShortName>" +
            "</tpay:Req>" +
            "</tpay:GetPurposeOfTransferList>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
