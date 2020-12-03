//
//  GetIdTypeResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetIdTypeResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var responseCode:Int!
    var description:String!
    var idTypeList:[IdType]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetIDTypeResponse.GetIDTypeResult.ResponseCode"]
        description <- map["s:Body.GetIDTypeResponse.GetIDTypeResult.Description"]
        idTypeList <- map["s:Body.GetIDTypeResponse.GetIDTypeResult.obj.diffgr:diffgram.GetIDType.tblIDTypeList"]
    }
    
    
}
class IdType: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    var nodeName: String!
    var id:Int!
    var idTypeName:String!
    var minLength:Int!
    var maxLength:Int!
    var isNumeric:Bool!
    var isAlphaNumeric:Bool!
    var isAddProof:Bool!
    var isIDProof:Bool!
    func mapping(map: XMLMap) {
        id <- map["IDType_ID"]
        idTypeName <- map["IDType"]
    }
}
