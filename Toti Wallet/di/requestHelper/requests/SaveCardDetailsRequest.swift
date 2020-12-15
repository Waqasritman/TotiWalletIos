//
//  SaveCardDetailsRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class SaveCardDetailsRequest {
    var customerNo = ""
    var customerCardNo = ""
    var cardName = ""
    var cardExpireDate = ""
    var languageId = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:SaveCardDetails>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_No>" + customerNo + "</tpay:Customer_No>" +
            "<tpay:Customer_CardName>" + cardName + "</tpay:Customer_CardName>" +
            "<tpay:Card_Number>" + customerCardNo + "</tpay:Card_Number>" +
            "<tpay:CardExpiry_Date>" + cardExpireDate + "</tpay:CardExpiry_Date>" +
            "</tpay:Req>" +
            "</tpay:SaveCardDetails>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
