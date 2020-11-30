//
//  AuthRepository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import Alamofire


class AuthRepository {
    
    
    func loginRequest(request:URLRequest ,completion: @escaping (LoginResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<LoginResponse>) in
                
                switch response.result {
                case .success( _):
                    
                    if response.value?.responseCode == 101 {
                        if let data = response.value {
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
                            completion(nil, response.value?.description)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func authRequest(request:URLRequest ,completion: @escaping (AuthenticationRespone?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<AuthenticationRespone>) in
                
                switch response.result {
                case .success( _):
                    
                    if response.value?.responseCode == 101 {
                        if let data = response.value {
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
                            completion(nil, response.value?.description)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    
    func verifyOTP(request:URLRequest ,completion: @escaping (VerifyOTPResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<VerifyOTPResponse>) in
                
                switch response.result {
                case .success( _):
                    
                    if response.value?.responseCode == 101 {
                        if let data = response.value {
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
                            completion(nil, response.value?.description)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    
    
}
