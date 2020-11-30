//
//  ProgressBar.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressBar:NSObject {
    
    static func showProgress() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
    }
    
    static func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    static func showError(error: String) {
        SVProgressHUD.showError(withStatus: error)
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    static func showSuccess(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    /**
               Mehtod to show AlertBox with give
               @param : title will accept string
               @param : message will accept string
    */
    static func showAlert(view: UIViewController , title:String , message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    
    static func showCancelAlert(view: UIViewController){
        let alert = UIAlertController(title: "Exit", message: "Are You Sure To Want To Cancel The Transaction", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            view.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    
    static func noInternetAlert(view: UIViewController) {
        let alert = UIAlertController(title: "Network Error", message: "No Internet Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
}
