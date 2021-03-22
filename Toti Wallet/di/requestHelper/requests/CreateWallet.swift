//
//  CreateWallet.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/21/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import Foundation
class CreateWalletRequest {
    var customerNo = ""
    var walletCurrency = ""
    var langugaeID = "1"
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:CreateWallet>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + langugaeID + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_Number>" + customerNo + "</tpay:Customer_Number>" +
            "<tpay:Wallet_Currency>" + walletCurrency + "</tpay:Wallet_Currency>" +
            "</tpay:Req>" +
            "</tpay:CreateWallet>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    
    }
}
