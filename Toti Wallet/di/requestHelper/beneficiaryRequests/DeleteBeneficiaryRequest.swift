//
//  DeleteBeneficiaryRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class DeleteBeneficiaryRequest {
    var customerNo:String = ""
    var beneficiaryNo:String = ""
    var langugaeId:String = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:deleteBeneficiary>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + langugaeId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNo>" + customerNo + "</tpay:CustomerNo>" +
            "<tpay:BeneficiaryNo>" + beneficiaryNo + "</tpay:BeneficiaryNo>" +
            "</tpay:Req>" +
            "</tpay:deleteBeneficiary>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
