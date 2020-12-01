//
//  EditCustomerProfileRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class EditCustomerProfileRequest {
    let customer =  RegisterUserRequest();
    var customerNo:String = ""
    var idNumber:String = ""
    var idType:Int!
    var idIssueDate:String = ""
    var idExpireDate = ""
    var residenceCountry =  ""
    var languageId = "1"
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:EditCustomerProfile>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:CustomerNo>" + customerNo + "</tpay:CustomerNo>" +
            "<tpay:FirstName>" + customer.firstName + "</tpay:FirstName>" +
            "<tpay:MiddleName>" + customer.middleName + "</tpay:MiddleName>" +
            "<tpay:LastName>" + customer.lastName + "</tpay:LastName>" +
            "<tpay:Address>" + customer.address + "</tpay:Address>" +
            "<tpay:DateOfBirth>" + customer.dob + "</tpay:DateOfBirth>" +
            "<tpay:Gender>" + customer.gender + "</tpay:Gender>" +
            "<tpay:MobileNumber>" + customer.phoneNumber + "</tpay:MobileNumber>" +
            "<tpay:Nationality>" + customer.nationality + "</tpay:Nationality>" +
            "<tpay:IDNumber>" + idNumber + "</tpay:IDNumber>" +
            "<tpay:IDType>" + String(idType) + "</tpay:IDType>" +
            "<tpay:IDIssueDate>" + idIssueDate + "</tpay:IDIssueDate>" +
            "<tpay:IDExpiryDate>" + idExpireDate + "</tpay:IDExpiryDate>" +
            "<tpay:SourceOfFund>" + "1" + "</tpay:SourceOfFund>" +
            "<tpay:IsActive>" + "1" + "</tpay:IsActive>" +
            "<tpay:SourceOfFund>" + "2" + "</tpay:SourceOfFund>" +
            "<tpay:EmailID>" + customer.email + "</tpay:EmailID>" +
            "<tpay:IDtype_Description>" + "1" + "</tpay:IDtype_Description>" +
            "<tpay:ResidenceCountry>" + "GBR" + "</tpay:ResidenceCountry>" +
            "<tpay:SourceOfFund_Desc>" + "123" + "</tpay:SourceOfFund_Desc>" +
            "</tpay:Req>" +
            "</tpay:EditCustomerProfile>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
