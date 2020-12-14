//
//  WRPayBillRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class WRPayBillRequest {
    static let shared = WRPayBillRequest()
    
    
    var customerNo = ""
    var payoutCurrency = ""
    var payOutAmount = ""
    var payInCurrency = ""
    var countryCode = ""
    var billerID = ""
    var skuID = ""
    var mobileAccount = "";
    var mobileAccount2 = "";
    var mobileAccount3 = "";
    var languageId = "1"
    var paymentTypeId = ""
    var cardNumber = ""
    var expireDate = ""
    var securityCode = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:WRPayBill>" +
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
            "<tpay:countryCode>" + countryCode + "</tpay:countryCode>" +
            "<tpay:BillerID>" + billerID + "</tpay:BillerID>" +
            "<tpay:SkuID>" + skuID + "</tpay:SkuID>" +
            "<tpay:Mob_Acc_No>" + mobileAccount + "</tpay:Mob_Acc_No>" +
            "<tpay:Mob_Acc_No1>" + mobileAccount2 + "</tpay:Mob_Acc_No1>" +
            "<tpay:Mob_Acc_No2>" + mobileAccount3 + "</tpay:Mob_Acc_No2>" +
            "<tpay:Payment_TypeID>" + paymentTypeId + "</tpay:Payment_TypeID>" +
            "<tpay:Card_Number>" + cardNumber + "</tpay:Card_Number>" +
            "<tpay:ExpiryDate>" + expireDate + "</tpay:ExpiryDate>" +
            "<tpay:SecurityCode>" + securityCode + "</tpay:SecurityCode>" +
            "</tpay:Req>" +
            "</tpay:WRPayBill>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
