//
//  GetBeneficiaryListswift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper
class GetBeneficiaryListResponse: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    
    init() {
        
    }
    
    var nodeName: String!
    var beneficiaryList:[BeneficiaryList]?
    var responseCode:Int?
    var description:String?
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetBeneficiaryListResponse.GetBeneficiaryListResult.ResponseCode"]
        description <- map["s:Body.GetBeneficiaryListResponse.GetBeneficiaryListResult.Description"]
        beneficiaryList <- map["s:Body.GetBeneficiaryListResponse.GetBeneficiaryListResult.obj.diffgr:diffgram.BeneficiaryList.tblBeneficiaryList"]
    }
    
    
}

class BeneficiaryList: XMLMappable {
    required init?(map: XMLMap) {
        
    }
    
    init() {
        
    }
    var isHoldForOfAC:Bool = false
    var beneficiaryNumber:String = ""
    var customerNo:String = ""
    var beneficiaryNo:String = ""
    var firstName:String = ""
    var middleName:String = ""
    var lastName:String = ""
    var nickName:String = ""
    var address:String = ""
    var dateOfBirth:String = ""
    var telephone:String = ""
    var nationality:String = ""
    var idNumber:String = ""
    var idType:String = ""
    var idIssueDate:String = ""
    var idExpiryDate:String = ""
    var payOutCurrency:String = ""
    var paymentMode:String = ""
    var paymentBranchCode:String = ""
    var bankName:String = ""
    var bankCountry:String = ""
    var branchName:String = ""
    var bankCode:String = ""
    var accountNumber:String = ""
    var isActive:String = ""
    var purposeCode:String = ""
    var purposeOfTransfer:String = ""
    var payoutAgent:String = ""
    var payoutBranchName:String = ""
    var payOutCountryCode:String = ""
    var payoutCityCode:String = ""
    var landMark:String = ""
    var zipCode:String = ""
    var emailId:String = ""
    var customerRelation:String = ""
    var idtype_Description:String = ""
    var nodeName: String!
    
    func mapping(map: XMLMap) {
        beneficiaryNumber <- map["BeneficiaryNumber"]
        customerNo <- map["CustomerNo"]
        beneficiaryNo <- map["BeneficiaryNo"]
        firstName <- map["FirstName"]
        middleName <- map["MiddleName"]
        lastName <- map["LastName"]
        address <- map["Address"]
        telephone <- map["Telephone"]
        nationality <- map["Nationality"]
        payOutCurrency <- map["PayOutCurrency"]
        paymentMode <- map["PaymentMode"]
        paymentBranchCode <- map["PaymentBranchCode"]
        
        isActive <- map["IsActive"]
        purposeCode <- map["PurposeCode"]
        purposeOfTransfer <- map["PurposeOfTransfer"]
        payoutAgent <- map["PayoutAgent"]
        payOutCountryCode <- map["PayOutCountryCode"]
        customerRelation <- map["CustomerRelation"]
        
        bankName <- map["BankName"]
        bankCountry <- map["BankCountry"]
        branchName <- map["BranchName"]
        bankCode <- map["BankCode"]
        accountNumber <- map["AccountNumber"]
    }
    
    
}
