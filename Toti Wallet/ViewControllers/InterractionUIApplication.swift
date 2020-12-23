//
//  InterractionUIApplication.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/22/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import Foundation
import UIKit

extension NSNotification.Name {
    public static let TimeOutUserInteraction: NSNotification.Name = NSNotification.Name(rawValue: "TimeOutUserInteraction")
}


class InterractionUIApplication: UIApplication {
    
    static let ApplicationDidTimoutNotification = "AppTimout"
    
    // The timeout in seconds for when to fire the idle timer.
    let timeoutInSeconds: TimeInterval = 5 * 60
    
    var idleTimer: Timer?
    
    // Listen for any touch. If the screen receives a touch, the timer is reset.
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches {
                if touch.phase == UITouch.Phase.began {
                    self.resetIdleTimer()
                }
            }
        }
    }
    // Resent the timer because there was user interaction.
    func resetIdleTimer() {
        if let idleTimer = idleTimer {
            // print("1")
            idleTimer.invalidate()
        }
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds, target: self, selector: #selector(self.idleTimerExceeded), userInfo: nil, repeats: false)
    }
    
    // If the timer reaches the limit as defined in timeoutInSeconds, post this notification.
    @objc func idleTimerExceeded() {
        NotificationCenter.default.post(name:Notification.Name.TimeOutUserInteraction, object: nil)
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let frontViewController = storyBoard.instantiateViewController(withIdentifier: "InactiveVC") as! InactiveVC
        let navigationController = UINavigationController(rootViewController: frontViewController)
        navigationController.navigationBar.isHidden = true
        
    
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        
        
//        if UserDefaults.standard.value(forKey: "isLogin") != nil {
//            if UserDefaults.standard.value(forKey: "isLogin")as! Bool == true{
//               // self.updateDeviceTokenApi()
//              //  AppDelegate.appAutoLogout = true
//
//
//
//
//
//
//
//
//
//                UIApplication.shared.keyWindow?.rootViewController = revealVC
//            }
        }

        
        
        
//        //Go Main page after 15 second
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        appDelegate.window?.rootViewController = yourVC
//        appDelegate.window?.makeKeyAndVisible()
        
        
    }
    //MARK:- Update Device Token
//    func updateDeviceTokenApi() {
//
//        let parameter = NSMutableDictionary()
//
//        parameter["userID"] = User.sharedInstanceOfUser.userID
//        parameter["userDeviceType"] = "iphone"
//        parameter["userDeviceID"] = ""
//        parameter["languageID"] = UserDefaults.standard.value(forKey: "LangID")
//
//        let dataLayerObj = UserDL()
//
//        dataLayerObj.UpdateDeviceTokenParameter(dictParam: parameter) { (response, isSucsses) in
//            if isSucsses {
//
//            } else  {
//            }
//        }
//    }
    
//}

