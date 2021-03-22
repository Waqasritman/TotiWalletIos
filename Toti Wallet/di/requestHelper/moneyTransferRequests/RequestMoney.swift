//
//  RequestMoney.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class RequestMoney {
    var customerNo:String = ""
    var mobileNo:String = ""
    var amount:Double = 0.0
    var description:String = ""
    var languageId:String = "1";
    var requestCurrency = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:RequestMoney>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:Mobile_Number>" + mobileNo.removeWhitespace() + "</tpay:Mobile_Number>" +
            "<tpay:Amount>" + String(describing: amount) + "</tpay:Amount>" +
            "<tpay:Currency>" + requestCurrency + "</tpay:Currency>" +
            "<tpay:Description>" + description + "</tpay:Description>" +
            "</tpay:Req>" +
            "</tpay:RequestMoney>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
