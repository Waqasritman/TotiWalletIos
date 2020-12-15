//
//  LoadVirtualCardRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class LoadVirtualCardRequest {
    var customerNo = ""
    var virtualCardNo = ""
    var loadAmount = ""
    var loadCurrency = "USD"
    var languageID = "1"
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:LoadVirtualCard>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:Virtual_CardNo>" + virtualCardNo + "</tpay:Virtual_CardNo>" +
            "<tpay:Load_Amount>" + loadAmount + "</tpay:Load_Amount>" +
            "<tpay:Load_Currency>" + loadCurrency + "</tpay:Load_Currency>" +
            "</tpay:Req>" +
            "</tpay:LoadVirtualCard>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
