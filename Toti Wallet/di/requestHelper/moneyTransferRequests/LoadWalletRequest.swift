//
//  LoadWalletRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class LoadWalletRequest {
    static let shared = LoadWalletRequest()
    var customerNo:String = ""
    var transferAmount:String = ""
    var cardNumber:String = ""
    var expireDate:String = ""
    var securityNumber:String = ""
    var walletCurrency:String = ""
    var languageId:String = "1"
    var paymentType:Int = 0
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:LoadWallet>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:Transfer_Amount>" + transferAmount + "</tpay:Transfer_Amount>" +
            "<tpay:Card_Number>" + cardNumber + "</tpay:Card_Number>" +
            "<tpay:Expiry_Date>" + expireDate + "</tpay:Expiry_Date>" +
            "<tpay:Security_Code>" + securityNumber + "</tpay:Security_Code>" +
            "<tpay:Wallet_Currency>" + walletCurrency + "</tpay:Wallet_Currency>" +
            "<tpay:Payment_Type>" +  String(describing: paymentType) + "</tpay:Payment_Type>" +
            "</tpay:Req>" +
            "</tpay:LoadWallet>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}


