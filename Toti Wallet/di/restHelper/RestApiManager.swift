//
//  RestApiManager.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
struct RestApiManager {
   static var baseURl:String = "https://183.87.134.37/TotipayImagesApi/"
   // static var baseURl:String = "https://totiwalletrest.totiwallet.com/"
    static let uploadAttachment = "TotiPayRestAPI/Images/UploadKYCImage"
    static let customerImage = "TotiPayRestAPI/Images/GetCustomerImage2"
    static let uploadCustomerImage = "TotiPayRestAPI/Images/AddCustomerImage"
    static let getVersion = "TotiPayRestAPI/Version/GetVersion"
    
    static let trackBaseURL = "https://ipapi.co/"
    
    
    static let getTrackURLKey = "xqgm3PkZb4RTXmxMmikizvh4d0IDDjELyWW9VtLYETSANVG8H0"
    
    static func getUploadAttachment() -> String {
        return baseURl + uploadAttachment
    }
    
    
    static func getCustomerImage() -> String {
        return baseURl + customerImage
    }
    
    
    static func getUploadCustomerImage() -> String {
        return baseURl + uploadCustomerImage
    }
    
}
