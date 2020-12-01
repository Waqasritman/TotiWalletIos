//
//  CalTransferRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class CalTransferRequest {
    var payInCurrency:String = ""
    var payoutCurrency:String = ""
    var transferCurrency:String = ""
    var transferAmount:Double = 0.0
    var paymentMode:Int = 1
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:CalTransfer>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:PayInCurrency>" + payInCurrency + "</tpay:PayInCurrency >" +
            "<tpay:PayoutCurrency>" + payoutCurrency + "</tpay:PayoutCurrency>" +
            "<tpay:TransferCurrency>" + transferCurrency + "</tpay:TransferCurrency>" +
            "<tpay:TransferAmount>" + String(describing:transferAmount) + "</tpay:TransferAmount>" +
            "<tpay:PaymentMode>" + String(describing:paymentMode) + "</tpay:PaymentMode>" +
            "</tpay:Req>" +
            "</tpay:CalTransfer>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
