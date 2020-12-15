//
//  B2BTransferDetails.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/15/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class B2BTransferDetails {
    static let shared = B2BTransferDetails()
    
    
    var receivingCountry = ""
    var customerNo = ""
    var beneName = ""
    var beneAddress = ""
    var beneContactNo = ""
    var detailsOfPayment = ""
    var payInAmount = ""
    var payOutAmount = ""
    var charges = "50"
    var purposeOfTransfer = ""
    var bankName = ""
    var accountNumber = ""
    var bankBranch = ""
    var bankAddress = ""
    var swiftBIC = ""
    var correspondentBank = ""
    var cbSwiftBIC = ""
    var cbAccountNumber = ""
    var languageId = "1";
    var receivingCurrency = ""
    
    
    public func getXML() -> String {
        let stringParams : String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">"
            + "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<tpay:B2BTransferDetails>" +
            "<tpay:Req>" +
            "<tpay:Credentials>" +
            "<tpay:PartnerCode>" + StaticHelper.PARTNER_CODE_VALUE + "</tpay:PartnerCode>" +
            "<tpay:UserName>" + StaticHelper.USER_NAME_VALUE + "</tpay:UserName>" +
            "<tpay:UserPassword>" + StaticHelper.USER_PASSWORD_VALUE + "</tpay:UserPassword>" +
            "<tpay:LanguageID>" + languageId + "</tpay:LanguageID>" +
            "</tpay:Credentials>" +
            "<tpay:Customer_Number>" + customerNo + "</tpay:Customer_Number>" +
            "<tpay:Bene_Name>" + beneName + "</tpay:Bene_Name>" +
            "<tpay:Bene_Address>" + beneAddress + "</tpay:Bene_Address>" +
            "<tpay:Bene_Contact_Number>" + beneContactNo + "</tpay:Bene_Contact_Number>" +
            "<tpay:Details_Of_Payment>" + detailsOfPayment + "</tpay:Details_Of_Payment>" +
            "<tpay:PayIn_Amount>" + payInAmount + "</tpay:PayIn_Amount>" +
            "<tpay:PayOut_Amount>" + payOutAmount + "</tpay:PayOut_Amount>" +
            "<tpay:Charges>" + "50" + "</tpay:Charges>" +
            "<tpay:Receiving_Currency>" + receivingCurrency + "</tpay:Receiving_Currency>" +
            "<tpay:Receiving_Country>" + receivingCountry + "</tpay:Receiving_Country>" +
            "<tpay:Purpose_Of_Transfer>" + purposeOfTransfer + "</tpay:Purpose_Of_Transfer>" +
            "<tpay:Bank_Name>" + bankName + "</tpay:Bank_Name>" +
            "<tpay:Bank_Branch>" + bankBranch + "</tpay:Bank_Branch>" +
            "<tpay:Bank_Address>" + bankAddress + "</tpay:Bank_Address>" +
            "<tpay:Swift_BIC>" + swiftBIC + "</tpay:Swift_BIC>" +
            "<tpay:Correspondent_Bank>" + correspondentBank + "</tpay:Correspondent_Bank>" +
            "<tpay:CB_Swift_BIC>" + cbSwiftBIC + "</tpay:CB_Swift_BIC>" +
            "<tpay:CB_Account_Number>" + cbAccountNumber + "</tpay:CB_Account_Number>" +
            "</tpay:Req>" +
            "</tpay:B2BTransferDetails>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>"
        
        return stringParams
    }
}
