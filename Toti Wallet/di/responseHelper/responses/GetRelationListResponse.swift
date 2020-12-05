//
//  GetRelationListResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetRelationListResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }

    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var relationList:[Relation]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetRelationListResponse.GetRelationListResult.ResponseCode"]
        description <- map["s:Body.GetRelationListResponse.GetRelationListResult.Description"]
        relationList <- map["s:Body.GetRelationListResponse.GetRelationListResult.obj.diffgr:diffgram.GetRelationList.tblRelationList"]
    }
}
class Relation: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    var nodeName: String!
    var id:Int!
    var relationName:String!
    func mapping(map: XMLMap) {
        id <- map["RelationID"]
        relationName <- map["RelationName"]
    }
}
