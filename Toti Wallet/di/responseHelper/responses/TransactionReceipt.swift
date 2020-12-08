//
//  TransactionReceipt.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class TransactionReceipt: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.ResponseCode"]
        description <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.Description"]
        transactionNumber <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.TransactionNumber"]
        transactionDateTime <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.TransactionDateTime"]
        sendingAmount <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.SendingAmount"]
        payInCurrency <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PayInCurrency"]
        receivingAmount <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.ReceivingAmount"]
        payoutCurrency <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PayOutCurrency"]
        commissionCharge <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.CommissionCharge"]
        otherCharge <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.OtherCharges"]
        vatCharge <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.VATCharges"]
        vatPercentage <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.VATPercentage"]
        totalPayable <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.TotalPayable"]
        exchangeRate <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.ExchangeRate"]
        purposeOfTransfer <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PurposeOfTransfer"]
        remitterNo <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.RemitterNo"]
        remitterName <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.RemitterName"]
        remitterContactNo <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.RemitterContactNo"]
        remitterAddress <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.RemitterAddress"]
       // remitterDOB <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.Description"]
        idType <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.ID_Type"]
      //  senderIdNumber <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.Description"]
        //senderIdExpireDate <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.ResponseCode"]
        relationWithBeneficiary <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.RelationWithBeneficiary"]
        beneficiaryNo <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BeneficiaryNo"]
        beneficiaryName <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BeneficiaryName"]
        
        beneficiaryAddress <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BeneficiaryAddress"]
        beneficiaryContactNo <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BeneficiaryContactNo"]
        bankName <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BankName"]
        bankAccountNo <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BankAccountNo"]
        bankBranch <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BankBranch"]
        bankAddress <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BankAddress"]
        bankCode <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.BankCode"]
        customerEmail <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.CustomerEmail"]
        payInCountry <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PayInCountry"]
        
        payOutCountry <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PayOutCountry"]
        earnPoint <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.earnPoint"]
        availPoints <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.AvailPoints"]
        paymentMode <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PaymentMode"]
        payoutAgent_Name <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.PayoutAgent_Name"]
        enteredBy <- map["s:Body.GetTransactionReceiptResponse.GetTransactionReceiptResult.EnteredBy"]
    }
    var transactionNumber:String!
    var transactionDateTime:String!
    var sendingAmount:Double!
    var payInCurrency:String!
    var receivingAmount:Double!
    var payoutCurrency:String!
    var commissionCharge:Double!
    var otherCharge:Double!
    var vatCharge:Double!
    var vatPercentage:Double!
    var totalPayable:Double!
    var exchangeRate:Double!
    var purposeOfTransfer:String!
    var remitterNo:String!
    var remitterName:String!
    var remitterContactNo:String!
    var remitterAddress:String!
    var remitterDOB:String!
    var idType:String!
    var senderIdNumber:String!
    var senderIdExpireDate:String!
    var relationWithBeneficiary:String!
    var beneficiaryNo:String!
    var beneficiaryName:String!
    var beneficiaryAddress:String!
    var beneficiaryContactNo:String!
    var bankName:String!
    var bankAccountNo:String!
    var bankBranch:String!
    var bankAddress:String!
    var bankCode:String!
    var customerEmail:String!
    var payInCountry:String!
    var payOutCountry:String!
    var earnPoint:String!
    var availPoints:String!
    var paymentMode:String!
    var payoutAgent_Name:String!
    var enteredBy:String!
}
