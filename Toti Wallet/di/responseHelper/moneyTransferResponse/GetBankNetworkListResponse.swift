//
//  GetBankNetworkListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class GetBankNetworkListResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var bankNetworkList:[BeneficiaryList]?
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetBankNetworkListResponse.GetBankNetworkListResult.ResponseCode"]
        description <- map["s:Body.GetBankNetworkListResponse.GetBankNetworkListResult.Description"]
        bankNetworkList <- map["s:Body.GetBankNetworkListResponse.GetBankNetworkListResult.obj.diffgr:diffgram.BankNetworkList.tblBankNetworkList"]
    }
    
    
}
class BankNetwork: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    
    func mapping(map: XMLMap) {
        bankName <- map["BankName"]
        bankAddress <- map["BranchName"]
        branchName <- map["BankAddress"]
        bankCode <- map["BankCode"]
    }
    
    var bankName = ""
    var bankAddress = ""
    var branchName = ""
    var bankCode = ""
}
