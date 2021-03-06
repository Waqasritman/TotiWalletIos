//
//  CurrencyListProtocol.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/3/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
protocol CurrencyListProtocol {
    func onSelectCurrency(currency:RecCurrency)
    func onCurrencyList(currencyList:[RecCurrency])
}
