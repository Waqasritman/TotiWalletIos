//
//  Repository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Alamofire
class Repository {
    func getBankDetails(request:URLRequest ,completion: @escaping (BankDepositDetailsResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<BankDepositDetailsResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = BankDepositDetailsResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func createWallet(request:URLRequest ,completion: @escaping (CreateWalletResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<CreateWalletResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = CreateWalletResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func getCCYWallets(request:URLRequest ,completion: @escaping (GetCCYWalletResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetCCYWalletResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = GetCCYWalletResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func getAppSettings(request:URLRequest ,completion: @escaping (AppSettingResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<AppSettingResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = AppSettingResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func loadVirtualCard(request:URLRequest ,completion: @escaping (LoadPrepaidCardResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<LoadPrepaidCardResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = LoadPrepaidCardResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func b2bTransfer(request:URLRequest ,completion: @escaping (B2BTransferResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<B2BTransferResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = B2BTransferResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func loadCustomerCards(request:URLRequest ,completion: @escaping (GetCardDetailsResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetCardDetailsResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = GetCardDetailsResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func createCustomerCardNo(request:URLRequest ,completion: @escaping (AddCustomerCardNoResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<AddCustomerCardNoResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = AddCustomerCardNoResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func getCustomerCardNo(request:URLRequest ,completion: @escaping (CustomerCardNoResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<CustomerCardNoResponse>) in
                
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
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = CustomerCardNoResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func getWalletTransHistory(request:URLRequest ,completion: @escaping (WalletTransferHistoryResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WalletTransferHistoryResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } 
                        } else {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = WalletTransferHistoryResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    
    func saveCardDetails(request:URLRequest ,completion: @escaping (SaveCardDetailsResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<SaveCardDetailsResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                let response = SaveCardDetailsResponse()
                                response.description = "something went wrong"
                                response.responseCode = 500
                                completion(response, nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = SaveCardDetailsResponse()
                            response.description = "something went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func getTransactionHistory(request:URLRequest ,completion: @escaping (TransactionHistoryResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<TransactionHistoryResponse>) in
                
                switch response.result {
                case .success( _):
                    if let data = response.value {
                        if data.responseCode == 101 {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            }
                        } else {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = TransactionHistoryResponse()
                            response.description = "something went wrong"
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
