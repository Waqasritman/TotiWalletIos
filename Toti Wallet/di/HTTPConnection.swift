//
//  HTTPConnection.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class HTTPConnection {
    
  static let url = URL(string:"https://183.87.134.37/TotipayPayinApi/TotiPay.svc?wsdl")
  //  static let url =  URL(string:"https://payinapi.totiwallet.com/TotiPay.svc?wsdl")
    public static func openConnection(stringParams:String , action:String) -> URLRequest {
        var xmlRequest = URLRequest(url: url!)
        //  let xmlRequest = NSMutableURLRequest(url: url!)
        xmlRequest.httpBody = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        xmlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        xmlRequest.addValue(action, forHTTPHeaderField: "Soapaction")
     //   xmlRequest.addValue(stringParams, forHTTPHeaderField: "Content-Length")
        xmlRequest.httpMethod = "POST"
        //  xmlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        xmlRequest.timeoutInterval = 5000

        return xmlRequest
    }
}
