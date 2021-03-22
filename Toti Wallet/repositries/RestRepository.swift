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
    
    func getVersion(param: [String:Any] ,completion: @escaping (AppVersionResponse?, Error?) -> ()) {
        var statusCode:Int = 0
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(RestApiManager.baseURl + RestApiManager.getVersion, method: .post , parameters: param ,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch (response.result){
            case .success( _):
                statusCode = (response.response?.statusCode)!
                if statusCode == 200 {
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let respons = try decoder.decode(AppVersionResponse.self, from: data)
                            DispatchQueue.main.async {
                                completion(respons , nil)
                            }
                        } catch {
                            completion(nil , error)
                        }
                    } else {
                        let errorBody = AppVersionResponse(ResponseCode: 500, Description: "Something went wrong", Version: "0.0")
                        completion(errorBody , nil)
                    }
                } else {
                    let errorBody = AppVersionResponse(ResponseCode: 500, Description: "Something went wrong", Version: "0.0")
                    completion(errorBody , nil)
                }
            case .failure(let error):
                completion(nil , error)
                return
            }
        }
    }
    
    func getTrackResponse(param: [String:Any] ,completion: @escaping (CountryTrackResponse?, Error?) -> ()) {
        var statusCode:Int = 0
        Alamofire.request("https://ipapi.co/json?=xqgm3PkZb4RTXmxMmikizvh4d0IDDjELyWW9VtLYETSANVG8H0",method: .get).responseJSON{
            (response) in
            switch (response.result) {
            case .success(let json):
                statusCode = (response.response?.statusCode)!
                if statusCode == 200 {
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let respons = try decoder.decode(CountryTrackResponse.self, from: data)
                            DispatchQueue.main.async {
                                completion(respons , nil)
                            }
                        } catch {
                            completion(nil , error)
                        }
                    }
                } else {
                    let errorBody = CountryTrackResponse(ip: "", country_name: "")
                    completion(errorBody , nil)
                }
            case .failure(let error):
                completion(nil , error)
                return
            }
        }
    }
    
    
    func getCustomerImage(param: [String:Any] ,completion: @escaping (GetProfileImage?, Error?) -> ()) {
        var statusCode:Int = 0
        Alamofire.request(RestApiManager.getCustomerImage(),method: .get, parameters: param).responseJSON{
            (response) in
            switch (response.result) {
            case .success(let json):
                statusCode = (response.response?.statusCode)!
                if statusCode == 200 {
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
                    let errorBody = GetProfileImage(ResponseCode: statusCode, ImageData: "", Description: "Something went wrong")
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
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(RestApiManager.getUploadCustomerImage(), method: .post , parameters: param ,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
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
                            let errorBody = SimpleResponse(ResponseCode: 500, Description: "Something went wrong")
                            completion(errorBody , nil)
                        }
                    }
                }
            case .failure(let error):
                completion(nil , error)
                return
            }
        }
    }
    
    
    func uploadKYCImage(param: [String:Any] ,completion: @escaping (SimpleResponse?, Error?) -> ()) {
        var statusCode:Int = 0
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(RestApiManager.getUploadAttachment(), method: .post , parameters: param
                          ,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
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
                                            let errorBody = SimpleResponse(ResponseCode: 500, Description: "Something went wrong")
                                            completion(errorBody , nil)
                                        }
                                    }
                                } else {
                                    let errorBody = SimpleResponse(ResponseCode: 500, Description: "Something went wrong")
                                    completion(errorBody , nil)
                                }
                            case .failure(let error):
                                completion(nil , error)
                                return
                            }
                          }
    }
}
