//
//  SplashVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SplashVC: BaseVC {
    
    let repo:RestRepositor = RestRepositor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//        if Network.isConnectedToNetwork() {
//            let request = AppVersionRequest()
//            print(request.toJSON())
//            repo.getVersion(param: request.toJSON()) { (response, error) in
//                if let error = error {
//                    self.showError(message: error.localizedDescription)
//                } else if response!.ResponseCode == 101 {
//                    if response!.Version == appVersion {
//                        self.getCountry()
//                    } else {
//                        self.versionAlert(view: self)
//                    }
//                } else if response!.Description != nil {
//                    self.showError(message:response!.Description)
//                } else {
//                    
//                }
//            }
//        } else {
//            self.noInternet()
//        }
        self.getCountry()
    }
    
    
    func versionAlert(view:UIViewController) {
        let alert = UIAlertController(title: "update_available".localized, message: "update_available_msg".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close".localized, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "update_txt".localized, style: .default, handler: { (action) in
            self.openAppStore()
        }))
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    
    func openAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1547109646"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
    
    func getCountry() {
        if Network.isConnectedToNetwork() {
            repo.getTrackResponse(param: toJSON(), completion: {(response , error) in
                if let error = error {
                    self.goToNext(error:error.localizedDescription)
                } else if !response!.ip.isEmpty {
                    preferenceHelper.setCountryData(ip: response!.ip, countryName: response!.country_name)
                    preferenceHelper.isDataNeedTohide(value: false)
                    let nextVC = ControllerID.getStartedNav.instance
                    self.presentWithFullScreen(nextVC)
                } else {
                    self.goToNext(error: "error")
                }
            })
        } else {
            self.noInternet()
        }
    }
    
    func goToNext(error:String) {
        preferenceHelper.setCountryData(ip: "0.0.0.0", countryName: error)
        preferenceHelper.isDataNeedTohide(value: false)
        let nextVC = ControllerID.getStartedNav.instance
        self.presentWithFullScreen(nextVC)
    }
    
    
    func toJSON() -> [String:Any] {
        return ["json" :RestApiManager.getTrackURLKey ]
    }
}
