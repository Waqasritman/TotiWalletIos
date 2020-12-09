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
    
    
    func editCustomerProfile(request:URLRequest ,completion: @escaping (EditCustomerProfileResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<EditCustomerProfileResponse>) in
                
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
                            let changePinResponse = EditCustomerProfileResponse()
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
    
    func resetPinForgot(request:URLRequest ,completion: @escaping (SetNewPinResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<SetNewPinResponse>) in
                
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
                            let changePinResponse = SetNewPinResponse()
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
    
    
    func matchPin(request:URLRequest ,completion: @escaping (MatchPINResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<MatchPINResponse>) in
                
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
                            let changePinResponse = MatchPINResponse()
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
    
    func getRealationList(request:URLRequest ,completion: @escaping (GetRelationListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetRelationListResponse>) in
                
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
                            let changePinResponse = GetRelationListResponse()
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
    
    
    
    func getReceiveCurrency(request:URLRequest ,completion: @escaping (GetSendRecCurrencyResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetSendRecCurrencyResponse>) in
                
                switch response.result {
                case .success( _):
                    
                    if response.value?.responseCode == 101 {
                        if let data = response.value {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch  {
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
    
    func registerUser(request:URLRequest ,completion: @escaping (CustomerRegistration?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<CustomerRegistration>) in
                
                switch response.result {
                case .success( _):
                    
                    if response.value?.responseCode == 101 {
                        if let data = response.value {
                            do {
                                DispatchQueue.main.async {
                                    completion(data , nil)
                                }
                            } catch  {
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
    
    
    func getCountriesList(request:URLRequest ,completion: @escaping (CountryListResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<CountryListResponse>) in
                
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
    
    func getCustomerProfile(request:URLRequest ,completion: @escaping (GetCustomerProfileResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetCustomerProfileResponse>) in
                
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
    
    
    
    func forgotPinApprovedUserRequest(request:URLRequest ,completion: @escaping (ForgotPinApprovedUserResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<ForgotPinApprovedUserResponse>) in
                
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
    
    
    
    func getCustomerWalletDetails(request:URLRequest ,completion: @escaping (GetCustomerWalletDetailsResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<GetCustomerWalletDetailsResponse>) in
                
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
                                let response = GetCustomerWalletDetailsResponse()
                                response.description = "some thing went wrong"
                                response.responseCode = 500
                                completion(response, nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = GetCustomerWalletDetailsResponse()
                            response.description = "some thing went wrong"
                            response.responseCode = 500
                            completion(response, nil)
                        }
                    }

                case .failure(let error):
                    completion(nil , error.localizedDescription)
                }

            }
    }
    
    
    func changePin(request:URLRequest ,completion: @escaping (ChangePinResponse?, String?) -> () ) {
        Alamofire.request(request)
            .responseXMLObject{(response: DataResponse<ChangePinResponse>) in
                
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
                            let changePinResponse = ChangePinResponse()
                            changePinResponse.description = "some thing went wrong"
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
