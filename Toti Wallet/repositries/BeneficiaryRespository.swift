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
}
