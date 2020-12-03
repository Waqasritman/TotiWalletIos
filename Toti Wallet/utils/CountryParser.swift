//
//  CountryParser.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
class CountryParser {
    static let SEND:Int = 2
    static let RECEIVE:Int = 1
    static let SEND_RECEIVE = 3
    
    
    static func getSendingCountry(list:[WRCountryList]) -> [WRCountryList] {
        var parsedCountries:[WRCountryList] = Array()
        for country in list {
            if country.countryType != RECEIVE {
                parsedCountries.append(country)
            }
        }
        return parsedCountries
    }
    
    
    static func getReceivingCountry(list:[WRCountryList]) -> [WRCountryList] {
        var parsedCountries:[WRCountryList] = Array()
        for country in list {
            if country.countryType != SEND {
                parsedCountries.append(country)
            }
        }
        return parsedCountries
    }
}
