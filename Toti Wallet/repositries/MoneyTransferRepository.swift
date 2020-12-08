//
//  MoneyTransferRepository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/1/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import Alamofire

class MoneyTransferRepository {
    
    
    func getReceipt(request:URLRequest ,completion: @escaping (TransactionReceipt?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<TransactionReceipt>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = TransactionReceipt()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    func getWalletBalance(request:URLRequest ,completion: @escaping (WalletBalanceResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WalletBalanceResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = WalletBalanceResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    func getSourceOfIncome(request:URLRequest ,completion: @escaping (GetSourceOfIncomeListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetSourceOfIncomeListResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = GetSourceOfIncomeListResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    func getPurposeList(request:URLRequest ,completion: @escaping (PurposeOfTransferListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<PurposeOfTransferListResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = PurposeOfTransferListResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    func getWalletCurrency(request:URLRequest ,completion: @escaping (WalletCurrencyListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WalletCurrencyListResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = WalletCurrencyListResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    
    func getRates(request:URLRequest ,completion: @escaping (CalTransferResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<CalTransferResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data , nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = CalTransferResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    func sendTotiPay(request:URLRequest ,completion: @escaping (TotiPaySendResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<TotiPaySendResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = TotiPaySendResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    func loadWallet(request:URLRequest ,completion: @escaping (LoadWalletResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<LoadWalletResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = LoadWalletResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
                
            }
    }
    
    
    func requestMoney(request:URLRequest ,completion: @escaping (RequestMoneyResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<RequestMoneyResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                let response = RequestMoneyResponse()
                                response.description = "Something went wrong"
                                response.responseCode = 500
                                completion(response, nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = RequestMoneyResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
            }
    }
    
    func walletToWallet(request:URLRequest ,completion: @escaping (WalletToWalletTransferResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WalletToWalletTransferResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(data, nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = WalletToWalletTransferResponse()
                            response.description = "Something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }
                    
                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }
            }
    }
    
    
  
    
    
}
