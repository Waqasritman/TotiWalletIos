//
//  TotiPaySend.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class TotiPaySend {
    static let shared = TotiPaySend()
    
    var sendingAmounttomatch:Double = 0.0
    var languageId:String = "1"
    
    var customerNo:String = ""
    var beneficiaryNo:String = ""
    var payOutCurrency:String = ""
    var payInCurrency:String = ""
    var transferAmount:Double!
    var sourceOfIncome:Int!
    var paymentTypeId:Int!
    var purposeOfTransfer:Int!
    
    var cardNumber = ""
    var expireDate = ""
    var securityNumber = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:TotiPaySend>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:Beneficiary_No>" + beneficiaryNo + "</tpay:Beneficiary_No>" +
            "<tpay:PayOutCurrency>" + payOutCurrency + "</tpay:PayOutCurrency>" +
            "<tpay:TransferAmount>" + "\(String(describing: transferAmount))" + "</tpay:TransferAmount>" +
            "<tpay:Payin_Currency>" + payInCurrency + "</tpay:Payin_Currency>" +
            "<tpay:SourceofIncome>" + "\(String(describing: sourceOfIncome))" + "</tpay:SourceofIncome>" +
            "<tpay:PurposeOfTransfer>" + "\(String(describing: purposeOfTransfer))" + "</tpay:PurposeOfTransfer>" +
            "<tpay:Payment_TypeID>" + "\(String(describing: paymentTypeId))" + "</tpay:Payment_TypeID>" +
            "<tpay:Card_Number>" + cardNumber + "</tpay:Card_Number>" +
            "<tpay:ExpiryDate>" + expireDate + "</tpay:ExpiryDate>" +
            "<tpay:SecurityCode>" + securityNumber + "</tpay:SecurityCode>" +
            "</tpay:Req>" +
            "</tpay:TotiPaySend>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
