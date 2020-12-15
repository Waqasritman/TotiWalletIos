//
//  WRPrepaidRechargeRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation

class WRPrepaidRechargeRequest {
    
    static let shared = WRPrepaidRechargeRequest()
    
    var customerNo = ""
    var payoutCurrency = ""  //
    var payOutAmount = ""
    var payInCurrency = ""
    var countryCode = ""  //
    var mobileNumber = "" //
    var planId = ""
    var languageId = "1"
    var paymentTypeId = ""
    var cardNumber = ""
    var expireDate = ""
    var securityCode = ""
    
    var operatorName = "" //
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:WRPrepaidRecharge>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNo>" + customerNo + "</tpay:CustomerNo>" +
            "<tpay:PayOutCurrency>" + payoutCurrency + "</tpay:PayOutCurrency>" +
            "<tpay:PayOutAmount>" + payOutAmount + "</tpay:PayOutAmount>" +
            "<tpay:PayinCurrency>" + payInCurrency + "</tpay:PayinCurrency>" +
            "<tpay:CountryCode>" + countryCode + "</tpay:CountryCode>" +
            "<tpay:MobileNumber>" + mobileNumber + "</tpay:MobileNumber>" +
            "<tpay:PlanId>" + planId + "</tpay:PlanId>" +
            "<tpay:Payment_TypeID>" + paymentTypeId + "</tpay:Payment_TypeID>" +
            "<tpay:Card_Number>" + cardNumber + "</tpay:Card_Number>" +
            "<tpay:ExpiryDate>" + expireDate + "</tpay:ExpiryDate>" +
            "<tpay:SecurityCode>" + securityCode + "</tpay:SecurityCode>" +
            "</tpay:Req>" +
            "</tpay:WRPrepaidRecharge>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
    
    
    func clearRequest() {
        customerNo = ""
        payoutCurrency = ""  //
        payOutAmount = ""
        payInCurrency = ""
        countryCode = ""  //
        mobileNumber = "" //
        planId = ""
        languageId = "1"
        paymentTypeId = ""
        cardNumber = ""
        expireDate = ""
        securityCode = ""
        
        operatorName = "" //
    }
}
