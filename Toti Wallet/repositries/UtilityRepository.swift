//
//  UtilityRepository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/14/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import Alamofire

class UtilityRepository {
    func getWRCountries(request:URLRequest ,completion: @escaping (WRCountryListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WRCountryListResponse>) in
                
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
                            let changePinResponse = WRCountryListResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func getStatus(request:URLRequest ,completion: @escaping (PrepaidStatusResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<PrepaidStatusResponse>) in
                
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
                            let changePinResponse = PrepaidStatusResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    func getMobileTopUpTypes(request:URLRequest ,completion: @escaping (WRBillerTypeResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WRBillerTypeResponse>) in
                
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
                            let changePinResponse = WRBillerTypeResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func getPrepaidOperators(request:URLRequest ,completion: @escaping (PrepaidOperatorResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<PrepaidOperatorResponse>) in
                
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
                            let changePinResponse = PrepaidOperatorResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    
    func getPrepaidPlans(request:URLRequest ,completion: @escaping (GetPrepaidPlansResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetPrepaidPlansResponse>) in
                
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
                            let changePinResponse = GetPrepaidPlansResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    
    func prepaidCharge(request:URLRequest ,completion: @escaping (WRPrepaidRechargeResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<WRPrepaidRechargeResponse>) in
                
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
                            let changePinResponse = WRPrepaidRechargeResponse()
                            changePinResponse.description = "something went wrong"
                            changePinResponse.responseCode = 500
                            completion(changePinResponse, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
}
