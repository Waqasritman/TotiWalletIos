//
//  AddBeneficiaryResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class AddBeneficiaryResponse:XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    
    init() {
        
    }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    var beneficiaryNo:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.BeneficiaryRegistrationResponse.BeneficiaryRegistrationResult.ResponseCode"]
        description <- map["s:Body.BeneficiaryRegistrationResponse.BeneficiaryRegistrationResult.Description"]
        beneficiaryNo <- map["s:Body.BeneficiaryRegistrationResponse.BeneficiaryRegistrationResult.BeneficiaryNo"]
    }
    
    
}
