//
//  Repository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Alamofire
class Repository {
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
                            DispatchQueue.main.async {
                                let response = GetCardDetailsResponse()
                                response.description = "something went wrong"
                                response.responseCode = 500
                                completion(response, nil)
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
}
