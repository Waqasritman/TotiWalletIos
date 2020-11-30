//
//  GetCustomerProfileResponse.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/30/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import XMLMapper

class GetCustomerProfileResponse:XMLMappable  {
    required init?(map: XMLMap) {
        
    }
    
    var nodeName: String!
    var responseCode:Int?
    var description:String?
    
    var customerNo:String = ""
    var date:String = ""
    var firstName:String = ""
    var middleName:String = ""
    var lastName:String = ""
    var address:String = ""
    var gender:String = ""
    var mobileNo:String = ""
    var nationality:String = ""
    var dateOfBirth:String = ""
    var email:String = ""
    var residenceCountry:String = ""
    var isApprovedKYC:Bool = false
    var idNumber:String = ""
    var idType:String = ""
    var idIssueDate:String = ""
    var idExpireDate:String = ""
    var sourceOfFund:String = ""
    var isActive:String = ""
    var idTypeDescription:String = ""
    var sourceOfDescription:String = ""
    
    
    func mapping(map: XMLMap) {
        responseCode <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.ResponseCode"]
        description <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.Description"]
        
        firstName <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.FirstName"]
        middleName <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.MiddleName"]
        lastName <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.LastName"]
        address <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.Address"]
        gender <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.Gender"]
        mobileNo <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.MobileNumber"]
        nationality <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.Nationality"]
        email <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.EmailID"]
        residenceCountry <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.ResidenceCountry"]
        
        isApprovedKYC <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IsKYC_Approved"]
        dateOfBirth <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.DateOfBirth"]
        idNumber <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IDNumber"]
        idType <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IDType"]
        idIssueDate <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IDIssueDate"]
        idExpireDate <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IDExpiryDate"]
        sourceOfFund <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.SourceOfFund"]
        isActive <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IsActive"]
        idTypeDescription <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.IDtype_Description"]
        
        sourceOfDescription <- map["s:Body.GetCustomerProfileResponse.GetCustomerProfileResult.SourceOfFund_Desc"]
    }
    
    
}
