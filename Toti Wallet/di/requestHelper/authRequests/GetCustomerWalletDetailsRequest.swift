//
//  GetCustomerWalletDetailsRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetCustomerWalletDetailsRequest {
    
    var customerNo = ""
    var mobileNumber = ""
    var languageId = "1"
    
    
    public func getXML() -> String {
         let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
             + "<soapenv:Header/>" +
             "<soapenv:Body>" +
             "<tpay:GetCustWalletDetails>" +
             "<tpay:Req>" +
             "<tpay:Credentials>" +
             "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
             "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
             "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
             "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
             "</tpay:Credentials>" +
             "<tpay:Customer_Number>" + customerNo + "</tpay:Customer_Number>" +
            "<tpay:Mobile_Number>" + mobileNumber.removeWhitespace() + "</tpay:Mobile_Number>" +
             "</tpay:Req>" +
             "</tpay:GetCustWalletDetails>" +
             "</soapenv:Body>" +
             "</soapenv:Envelope>"
         
         return stringParams
     }
}
