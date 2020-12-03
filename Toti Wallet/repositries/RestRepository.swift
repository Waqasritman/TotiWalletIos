//
//  RestRepository.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import Alamofire

class RestRepositor {
    
    
    
    func getCustomerImage(param: [String:Any] ,completion: @escaping (GetProfileImage?, Error?) -> ()) {
        var statusCode:Int = 0
        Alamofire.request(RestApiManager.getCustomerImage(), method: .get).responseJSON{
            (response) in
            switch (response.result) {
            case .success(let json):
                statusCode = (response.response?.statusCode)!
                if statusCode == 101 {
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let respons = try decoder.decode(GetProfileImage.self, from: data)
                            DispatchQueue.main.async {
                                completion(respons , nil)
                            }
                        } catch {
                            completion(nil , error)
                        }
                    }
                } else {
                    let errorBody = GetProfileImage(ResponseCode: 500, ImageData: "", Description: "Something went wrong")
                    completion(errorBody , nil)
                }
            case .failure(let error):
                completion(nil , error)
                return
            }
        }
    }
    
    func uploadCustomerImage(param: [String:Any] ,completion: @escaping (SimpleResponse?, Error?) -> ()) {
           var statusCode:Int = 0
              Alamofire.request(RestApiManager.getUploadCustomerImage(), method: .post , parameters: param).responseJSON { (response) in
               switch (response.result){
               case .success( _):
                   print(response)
                   statusCode = (response.response?.statusCode)!
                   print(statusCode)
                   if statusCode == 200 {
                       if let data = response.data {
                           do {
                               let decoder = JSONDecoder()
                               let respons = try decoder.decode(SimpleResponse.self, from: data)
                               DispatchQueue.main.async {
                                   completion(respons , nil)
                               }
                           } catch {
                               print(error)
                           }
                       }
                   }
               case .failure(let error):
                completion(nil , error)
                return
            }
        }
    }
}
