//
//  UrlToBase64.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class UrlToBase64 {
    
    public static func convertUrlIntoBase64(url:URL) -> String{
        let fileData = NSData(contentsOf: url)
        return fileData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
   
}
