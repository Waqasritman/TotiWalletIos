//
//  UploadKYCImageRequest.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/19/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class UploadKYCImageRequest {
    var credentials = Credentials()
    var Customer_No = ""
    var Image = ""
    var Image_Name = ""
    
    
    func toJSON() -> [String:Any] {
        return ["credentials" : credentials.toJSON() , "Customer_No" :Customer_No , "Image": Image ,"Image_Name": Image_Name ]
    }
}
