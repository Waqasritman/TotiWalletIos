//
//  BeneficiaryRespository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import Alamofire

class BeneficiaryRespository {
    
    
    func getYBranch(request:URLRequest ,completion: @escaping (YBranchResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<YBranchResponse>) in
                
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
                            let response = YBranchResponse()
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
    
    func getYLocations(request:URLRequest ,completion: @escaping (YLocationResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<YLocationResponse>) in
                
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
                            let response = YLocationResponse()
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
    
    func getYCities(request:URLRequest ,completion: @escaping (YCityResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<YCityResponse>) in
                
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
                            let response = YCityResponse()
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
    
    
    
    func getBeneficiaryList(request:URLRequest ,completion: @escaping (GetBeneficiaryListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetBeneficiaryListResponse>) in
                
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
                            let response = GetBeneficiaryListResponse()
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
    
    
    func getCashNetworkList(request:URLRequest
                            ,completion: @escaping (GetCashNetworkListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetCashNetworkListResponse>) in
                
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
                            let response = GetCashNetworkListResponse()
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
    
    
    func addBeneficiary(request:URLRequest
                            ,completion: @escaping (AddBeneficiaryResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<AddBeneficiaryResponse>) in
                
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
                            let response = AddBeneficiaryResponse()
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
