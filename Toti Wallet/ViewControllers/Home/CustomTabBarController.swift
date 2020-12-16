//
//  CustomTabBarController.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.insertEmptyTabItem("Quick Pay", atIndex: 2)
    }
    
    open func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = ControllerID.quickPayVC.instance
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.isEnabled = false
        
        self.viewControllers?.insert(vc, at: atIndex)
    }
}
