//
//  GetSourceOfIncomeListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetSourceOfIncomeListResponse: XMLMappable {
    
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var idTypeList:[SourceOfIncome]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetSourceOfIncomeListResponse.GetSourceOfIncomeListResult.ResponseCode"]
        description <- map["s:Body.GetSourceOfIncomeListResponse.GetSourceOfIncomeListResult.Description"]
        idTypeList <- map["s:Body.GetSourceOfIncomeListResponse.GetSourceOfIncomeListResult.obj.diffgr:diffgram.GetSourceOfIncomeList.tblGetSourceOfIncomeList"]

    }
}
class SourceOfIncome: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    var nodeName: String!
    var id:Int!
    var incomeName:String!
    func mapping(map: XMLMap) {
        id <- map["SourceOfIncomeID"]
        incomeName <- map["SourceOfIncomeName"]
    }
}
