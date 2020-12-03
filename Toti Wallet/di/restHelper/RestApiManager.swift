//
//  RestApiManager.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class RestApiManager {
    static var baseURl:String = "https://183.87.134.37/TotipayImagesApi/"
    
    static let uploadAttachment = "TotiPayRestAPI/Images/UploadKYCImage"
    static let customerImage = "TotiPayRestAPI/Images/GetCustomerImage2"
    static let uploadCustomerImage = "TotiPayRestAPI/Images/AddCustomerImage"
    
    
    
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
