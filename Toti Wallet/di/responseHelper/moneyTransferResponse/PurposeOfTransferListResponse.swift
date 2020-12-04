//
//  PurposeOfTransferListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class PurposeOfTransferListResponse: XMLMappable {
    init() { }
    
    required init?(map: XMLMap) { }

    var nodeName: String!
    var purposeList:[PurposeOfTransfer]?
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetPurposeOfTransferListResponse.GetPurposeOfTransferListResult.ResponseCode"]
        description <- map["s:Body.GetPurposeOfTransferListResponse.GetPurposeOfTransferListResult.Description"]
        purposeList <- map["s:Body.GetPurposeOfTransferListResponse.GetPurposeOfTransferListResult.obj.diffgr:diffgram.GetPurposeList.tblPurposeList"]
    }

}

class  PurposeOfTransfer: XMLMappable {
    required init?(map: XMLMap) {}
    init() {}
    var nodeName: String!
    var purposeOfTransferID:Int!
    var purposeOfTransfer:String!
    func mapping(map: XMLMap) {
        purposeOfTransferID <- map["PurposeOfTransferID"]
        purposeOfTransfer <- map["PurposeOfTranfer"]
    }
    
}
