//
//  ChangePinResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class ChangePinResponse :XMLMappable{
    
    
    required init?(map: XMLMap) { }
    
    init() {
        
    }
    
    var nodeName: String!
    
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.ChangePINResponse.ChangePINResult.ResponseCode"]
        description <- map["s:Body.ChangePINResponse.ChangePINResult.Description"]
    }
    
    
}
