//
//  BeneficiaryAddRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class BeneficiaryAddRequest {
    var countryID:Int?
    var cityID:Int =  -1
    var locationID:Int = -1
    
    var customerNo:String = ""
    var FirstName:String = ""  //
    var MiddleName:String = "" //
    var LastName:String = "" //
    var Address:String = "" //
    var Telephone:String = ""
    var PayOutCurrency:String = ""
    var PaymentMode:String = ""
    var PayOutBranchCode:String = ""
    var BankName:String = ""
    var BankCountry:String = ""
    var BranchNameAndAddress:String = ""
    var BankCode:String = ""
    var AccountNumber:String = ""
    var PurposeCode:String = "1"
    var PayoutCountryCode:String = ""
    var CustomerRelation:String = ""
    var BankBranch:String = ""
    
    //extra variables
    var beneficiaryCountryId:Int?
    var beneficiaryNo:String = ""
    var languageId:String = "1"
    var countryRegion:String = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:BeneficiaryRegistration>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNo>" + customerNo + "</tpay:CustomerNo>" +
            "<tpay:FirstName>" + FirstName + "</tpay:FirstName>" +
            "<tpay:MiddleName>" + MiddleName + "</tpay:MiddleName>" +
            "<tpay:LastName>" + LastName + "</tpay:LastName>" +
            "<tpay:Address>" + Address + "</tpay:Address>" +
            "<tpay:Telephone>" + Telephone + "</tpay:Telephone>" +
            "<tpay:PayOutCurrency>" + PayOutCurrency + "</tpay:PayOutCurrency>" +
            "<tpay:PaymentMode>" + PaymentMode + "</tpay:PaymentMode>" +
            "<tpay:PayOutBranchCode>" + PayOutBranchCode + "</tpay:PayOutBranchCode>" +
            "<tpay:BankName>" + BankName + "</tpay:BankName>" +
            "<tpay:BankCountry>" + BankCountry + "</tpay:BankCountry>" +
            "<tpay:BranchNameAndAddress>" + BranchNameAndAddress + "</tpay:BranchNameAndAddress>" +
            "<tpay:BankCode>" + BankCode + "</tpay:BankCode>" +
            "<tpay:AccountNumber>" + AccountNumber + "</tpay:AccountNumber>" +
            "<tpay:PurposeCode>" + PurposeCode + "</tpay:PurposeCode>" +
            "<tpay:PayoutCountryCode>" + PayoutCountryCode + "</tpay:PayoutCountryCode>" +
            "<tpay:CustomerRelation>" + CustomerRelation + "</tpay:CustomerRelation>" +
            "<tpay:BankBranch>" + BankBranch + "</tpay:BankBranch>" +
            "</tpay:Req>" +
            "</tpay:BeneficiaryRegistration>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
