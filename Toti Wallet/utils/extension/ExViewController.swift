//
//  ExViewController.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/23/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
extension UIViewController {
    func observeTimeout() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTimeout),
            name: Notification.Name.TimeOutUserInteraction,
            object: nil)
    }

    @objc func handleTimeout() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let frontViewController = storyBoard.instantiateViewController(withIdentifier: "InactiveVC") as! InactiveVC
        let navigationController = UINavigationController(rootViewController: frontViewController)
        navigationController.navigationBar.isHidden = true
        
    
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}
