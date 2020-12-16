//
//  BaseVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/29/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SDWebImage
import PhoneNumberKit
import Alamofire
let APPDELEGATE =  UIApplication.shared.delegate as! AppDelegate
let preferenceHelper = PreferenceHelper.preferenceHelper
let  arrForLanguages:[(language:String,code:String)] = [(language: "English", code: "en"),(language: "عربى", code: "ar")]



extension URLSession {
    func cancelTasks(completionHandler: @escaping (() -> Void)) {
        self.getAllTasks { (tasks: [URLSessionTask]) in
            for task in tasks {
                if let url = task.originalRequest?.url?.absoluteString {
                    print("\(#function) \(url) cancel")
                }
                
                task.cancel()
            }
            
            DispatchQueue.main.async(execute: {
                completionHandler()
            })
        }
    }
}
class BaseVC: UIViewController , PopUpProtocol {
   
    func gotoHome(){
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
    func changed(_ language: Int)
    {
        showProgress()
        var transition: UIView.AnimationOptions = .transitionFlipFromLeft
        
        LocalizeLanguage.setAppleLanguageTo(lang: language)
        
        if arrForLanguages[language].code == "ar"
        {
          UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else
        {
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
      //  Localizer.doTheMagic()
        Alamofire.SessionManager.default.session.cancelTasks { [unowned self] in
            self.hideProgress()
            let appWindow: UIWindow? = APPDELEGATE.window
             let storyBoard: UIStoryboard = UIStoryboard.init(name: "GetStarted", bundle: nil)
             let vC: UIViewController? = storyBoard.instantiateInitialViewController()
             
           //  appWindow?.removeFromSuperviewAndNCObserver()
            // appWindow?.rootViewController?.removeFromParentAndNCObserver()
             
             appWindow?.removeFromSuperview()
             appWindow?.rootViewController?.removeFromParent()
            
             appWindow?.rootViewController = vC
             appWindow?.makeKeyAndVisible()
             appWindow?.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
             
             UIView.transition(with: appWindow ?? UIWindow(),
                               duration: 0.5,
                               options: transition,
                               animations: { () -> Void in
             }) { (finished) -> Void in
                 appWindow?.backgroundColor = UIColor.clear
             }
         }
    }

    /**check the phonenumber format*/
    let phoneNumberkit = PhoneNumberKit()
   // let preferenceHelper = PreferenceHelper.preferenceHelper
    func isValidate() -> Bool {return true}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.semanticContentAttribute = .forceRightToLeft
       // self.hideKeyboardWhenTappedAround()
    }
    


    
    public func showSuccess(message:String)  {
        ProgressBar.showSuccess(message: message)
    }
    
    public func showError(message:String) {
        ProgressBar.showError(error: message)
    }
    
    
    public func verifyNumber(number:String) -> Bool {
        /**Verify the number international correction*/
        do {
            let userNumberIs = number
            _ = try phoneNumberkit.parse(userNumberIs)
            return true
        }catch {
            return false
        }
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
   

    func getFormatedDate(date:Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "MM/dd/yyyy"
        return dateformatter.string(from: date)
    }
    
    
    func getFormatedPinDate(date:Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "MM-dd-yyyy"
        return dateformatter.string(from: date)
    }

}
