//
//  BeneficiaryParser.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/4/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class BeneficiaryParser {
     static let CASH_BENEFICIARY = "cash";
     static let BANK_BENEFICIARY = "bank";
    
    
    static func getCashBene(list:[BeneficiaryList]) -> [BeneficiaryList] {
        var parsed:[BeneficiaryList] = Array()
        for beneficiary in list {
            if beneficiary.paymentMode.lowercased() == CASH_BENEFICIARY {
                parsed.append(beneficiary)
            }
        }
        return parsed
    }
    
    
    static func getBankBene(list:[BeneficiaryList]) -> [BeneficiaryList] {
        var parsed:[BeneficiaryList] = Array()
        for beneficiary in list {
            if beneficiary.paymentMode.lowercased() == BANK_BENEFICIARY {
                parsed.append(beneficiary)
            }
        }
        return parsed
    }
}
