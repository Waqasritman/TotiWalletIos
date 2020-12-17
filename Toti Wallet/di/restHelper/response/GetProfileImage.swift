//
//  GetProfileImage.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class GetProfileImage: Codable {
    let ResponseCode: Int
    let ImageData, Description: String
    
    
    enum CodingKeys: String, CodingKey {
        case ResponseCode = "ResponseCode"
        case ImageData = "ImageData"
        case Description = "Description"
          
    }
    
    init(ResponseCode: Int, ImageData: String, Description: String) {
        self.ResponseCode = ResponseCode
        self.ImageData = ImageData
        self.Description = Description
    }
    
}

