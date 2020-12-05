//
//  YBranchResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class YBranchResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var list:[YBranches]!
    var responseCode:Int!
    var description:String!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetYBranchesResponse.GetYBranchesResult.ResponseCode"]
        description <- map["s:Body.GetYBranchesResponse.GetYBranchesResult.Description"]
        list <- map["s:Body.GetYBranchesResponse.GetYBranchesResult.obj.diffgr:diffgram.NewDataSet.Table1"]
    }
    
}
class YBranches: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    
    var nodeName: String!
    var branchID:Int!
    var branchName:String!
    func mapping(map: XMLMap) {
        branchID <- map["Branch_ID"]
        branchName <- map["Branch_Name"]
    }
}
