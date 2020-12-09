//
//  TransactionHistoryResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/9/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class TransactionHistoryResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {}
    var nodeName: String!
    var transactionHistory:[TransactionHistory]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.TransactionHistoryResponse.TransactionHistoryResult.ResponseCode"]
        description <- map["s:Body.TransactionHistoryResponse.TransactionHistoryResult.Description"]
        transactionHistory <- map["s:Body.TransactionHistoryResponse.TransactionHistoryResult.obj.diffgr:diffgram.NewDataSet.Table1"]
    }
    
}
class TransactionHistory: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {}
    var nodeName: String!
    func mapping(map: XMLMap) {
        transactionDate <- map["TRANSACTIONDATE"]
        purposeOfTransfer <- map["PURPOSEOFTRANSFER"]
        paymentType <- map["PAYMENTTYPE"]
        bankName <- map["BANKNAME"]
        transactionNumber <- map["TRANSACTIONNUMBER"]
        senderName <- map["SENDERNAME"]
        paymentTypeID <- map["PAYMENTTYPEID"]
        receiverName <- map["RECEIVERNAME"]
        sendingAmount <- map["SENDINGAMOUNT"]
        receiverAmount <- map["RECEIVINGAMOUNT"]
        status <- map["STATUS"]
        currency  <- map["CCYSHORTNAME"]
    }
    var transactionDate:String = ""
    var purposeOfTransfer:String = ""
    var paymentType:String = ""
    var bankName:String = ""
    var transactionNumber:String = ""
    var senderName:String = ""
    var statusID:Int = -1
    var paymentTypeID:Int = -1
    var receiverName:String = ""
    var sendingAmount:String = ""
    var receiverAmount:String = ""
    var status:String = ""
    var currency:String = ""
}
