//
//  StaticHelper.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class StaticHelper {
    static var shared = StaticHelper()
  
    static let PARTNER_CODE_VALUE = "111335";
    static let USER_NAME_VALUE = "TOTIPAYAPIUSER";
    static let USER_PASSWORD_VALUE = "w*QAqZYY";
    static let LANGUAGE_ID = "";
    
    
    static let ENVELOP_OPENER = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tpay=\"TPay\">";
    static let ENVELOP_CLOSER = "</soapenv:Envelope>";
    
    static let HEADER_EMPTY = "<soapenv:Header/>";
    
    static let BODY_OPEN = "<soapenv:Body>";
    static let BODY_CLOSE = "</soapenv:Body>";
}
