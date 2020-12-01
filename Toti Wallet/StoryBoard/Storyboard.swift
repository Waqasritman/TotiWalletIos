//
//  Storyboard.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 25/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

enum ControllerID<T: UIViewController> : String {
    
    case splashVC = "splashVC"
    case getStartedNav = "navStarted"
    case loginOptionVC = "LoginOptionVC"
    case loginVC = "LoginVC"
    case signUpVC = "SignUpVC"
    case verifyOptVC = "VerifyOptVC"
    case selectCountryVC = "SelectCountryVC"
    case forgotPassGetEmailVC = "ForgotPassGetEmailVC"
    case forgotPassGetPinVC = "ForgotPassGetPinVC"
    case forgotPassGetDataVC = "ForgotPassGetDataVC"
    case forgotPassPinCV = "ForgotPassOTPVC"
    
    case profileBasicDetailVC = "ProfileBasicDetailVC"
    case profileAddressDetailVC = "ProfileAddressDetailVC"
    case tabbar = "tabbar"
    
    case quickPayVC = "QuickPayVC"
    case businessTranscationVC = "BusinessTranscationVC"
    case myQRCode = "MyQRCode"
    case settingsVC = "SettingsVC"
    case billPaymentVC = "BillPayment"
    case changePinVC = "ChangePinVC"
    
    var instance: T {
        return storyboard.instance(viewController: self.rawValue) as T
    }
    
    var storyboard: Storyboard {
        
        switch self {
        case .splashVC, .getStartedNav, .loginOptionVC, .loginVC, .signUpVC, .verifyOptVC, .selectCountryVC, .forgotPassGetEmailVC, .forgotPassGetPinVC, .forgotPassGetDataVC , .forgotPassPinCV :
            return .GetStarted
        case .profileBasicDetailVC, .profileAddressDetailVC:
            return .Profile
        case .tabbar, .quickPayVC:
            return .Main
        case .businessTranscationVC, .myQRCode, .settingsVC, .billPaymentVC ,.changePinVC:
            return .SideMenu
        }
    }
    
}

enum Storyboard: String {
    case GetStarted
    case Profile
    case Main
    case SideMenu
    
    func instance<T>(viewController: String) -> T {
        return self.refrence.instantiateViewController(withIdentifier: viewController) as! T
    }
    
    func instantiateViewController<T: UIViewController>(withViewClass: T.Type) -> T {
        return self.refrence.instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
    
    var refrence: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}


extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(withViewClass: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
}

