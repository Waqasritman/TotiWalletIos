//
//  WalletTransferHistoryResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/9/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class WalletTransferHistoryResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    var nodeName: String!
    var walletHistoryList:[WalletHistory]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.WalletTransactionHistoryResponse.WalletTransactionHistoryResult.ResponseCode"]
        description <- map["s:Body.WalletTransactionHistoryResponse.WalletTransactionHistoryResult.Description"]
        walletHistoryList <- map["s:Body.WalletTransactionHistoryResponse.WalletTransactionHistoryResult.obj.diffgr:diffgram.NewDataSet.Table1"]
    }
    
}
class WalletHistory: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    var nodeName: String!

    func mapping(map: XMLMap) {
        transactionDate <- map["TRANSACTIONDATE"]
        paymentType <- map["PAYMENTTYPE"]
        receiverNumber <- map["BENE_MOBILE_NO"]
        transactionNumber <- map["TRANSACTIONNUMBER"]
        sendingCurrency <- map["SENDINGCURRENCY"]
        customerNo <- map["CUSTOMERNO"]
        status <- map["STATUS"]
        paymentTypeID <- map["PAYMENTTYPEID"]
        senderName <- map["SENDERNAME"]
        receiverName <- map["RECEIVERNAME"]
        sendingAmount <- map["SENDINGAMOUNT"]
        receivingAmount <- map["RECEIVINGAMOUNT"]
        
    }
    var transactionDate:String = ""
    var paymentType:String = ""
    var receiverNumber:String = ""
    var transactionNumber:String = ""
    var sendingCurrency:String = ""
    var customerNo:String = ""
    var status:String = ""
    var statusID:Int = -1
    var paymentTypeID:Int = -1
    var senderName:String = ""
    var receiverName:String = ""
    var sendingAmount:String = ""
    var receivingAmount:String = ""
}
