//
//  GetPrepaidPlansResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetPrepaidPlansResponse: XMLMappable {
    required init?(map: XMLMap) {}
    init() {
        
    }
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var dummyPlans:[GetPrepaidPlan] = Array()
    var plansData:[GetPrepaidPlan] = Array()
    var rechargeTypes:[RechargeType]!
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetWRPrepaidPlansResponse.GetWRPrepaidPlansResult.ResponseCode"]
        description <- map["s:Body.GetWRPrepaidPlansResponse.GetWRPrepaidPlansResult.Description"]
        rechargeTypes <- map["s:Body.GetWRPrepaidPlansResponse.GetWRPrepaidPlansResult.Obj.rechargeSubTypes"]
        plansData.removeAll()
        for rechargeType in rechargeTypes {
            
            for type in rechargeType.rechargeType {
                dummyPlans.removeAll()
                let s = "s:Body.GetWRPrepaidPlansResponse.GetWRPrepaidPlansResult.Obj.plans." + "\(type)" + ".plansdata"
                print(s)
                dummyPlans <- map[s]
              
                plansData.append(contentsOf: dummyPlans)
            }
            
           
        }
    }
    
    
}

class RechargeType:XMLMappable {
    func mapping(map: XMLMap) {
        rechargeType <- map["string"]
    }
    
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var rechargeType:[String]!
}

class Plans:XMLMappable {
    
    
    func mapping(map: XMLMap) {
        plansData <- map["string"]
    }
    
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var plansData:[String]!
}


class GetPrepaidPlan: XMLMappable {
    required init?(map: XMLMap) { }
    
    var nodeName: String!
    var planId: String = ""
    var rechargeSubType: String = ""
    var mrp:String = ""
    var rechargeAmount: String = ""
    var benefits: String = ""
    var talkTime:String = ""
    func mapping(map: XMLMap) {
        planId <- map["planId"]
        rechargeSubType <- map["rechargeSubType"]
        mrp <- map["MRP"]
        rechargeAmount <- map["rechargeAmount"]
        benefits <- map["benefits"]
        talkTime <- map["talktime"]
    }
    
    
}
