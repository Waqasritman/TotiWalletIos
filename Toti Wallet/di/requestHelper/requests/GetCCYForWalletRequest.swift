//
//  GetCCYForWalletRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/20/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class GetCCYForWalletRequest {
    var languageID = "1"
    var customerNo = ""
    var actionType = "CW"
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:GetCCYForWallet>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNumber>" + customerNo.removeWhitespace() + "</tpay:CustomerNumber>" +
            "<tpay:ActionType>" + actionType + "</tpay:ActionType>" +
            "</tpay:Req>" +
            "</tpay:GetCCYForWallet>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
