//
//  BaseVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit


class BaseVC: UIViewController , PopUpProtocol {
   
    

    
    func isValidate() -> Bool {return true}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    public func showSuccess(message:String)  {
        ProgressBar.showSuccess(message: message)
    }
    
    public func showError(message:String) {
        ProgressBar.showError(error: message)
    }
    
    
    public func showProgress() {
        ProgressBar.showProgress()
    }
    
    
    public func hideProgress() {
        ProgressBar.hideProgress()
    }
    
    
    public func noInternet() {
        ProgressBar.noInternetAlert(view: self)
    }
    
    
    public func showAlert(title:String , message:String) {
        AlertView.instance.delegate = self
        AlertView.instance.showAlert(title: title, message: message)
    }
    
    public func handleAction(action: Bool) {
        
    }


}