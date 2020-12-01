//
//  WalletToWalletTransferRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class WalletToWalletTransferRequest {
    var customerNo = ""
    var receiptMobileNo = ""
    var transferAmount = ""
    var description = ""
    var payInCurrency = ""
    var receiptCurrency = ""
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:WalletToWalletTransfer>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:PayIn_Currency>" + payInCurrency + "</tpay:PayIn_Currency>" +
            "<tpay:Recipient_Mobile_No>" + receiptMobileNo + "</tpay:Recipient_Mobile_No>" +
            "<tpay:Recipient_Currency>" + "\(String(describing: receiptCurrency))" + "</tpay:Recipient_Currency>" +
            "<tpay:Transfer_Amount>" + transferAmount + "</tpay:Transfer_Amount>" +
            "<tpay:Description>" + "\(String(describing: description))" + "</tpay:Description>" +
            "</tpay:Req>" +
            "</tpay:WalletToWalletTransfer>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
