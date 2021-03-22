//
//  CustomTabBarController.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, MyTabBarDelegate {
    
    @IBOutlet weak var tabar: MyTabBar!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
       
        (self.tabBar as! MyTabBar).delegatse = self
        
        self.insertEmptyTabItem("Quick Pay", atIndex: 2)
        tabar.items?[0].title = "Home"
        tabar.items?[1].title = "history".localized
        tabar.items?[2].title = "quick_pay".localized
        tabar.items?[3].title = "my_cards_txt".localized
        tabar.items?[4].title = "our_rates".localized
        
        
        tabar.items?[2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
    open func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = ControllerID.quickPayVC.instance
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.isEnabled = false
        self.viewControllers?.insert(vc, at: atIndex)
    }
    
    func Tesst() {
       self.selectedIndex = 2
    }
}
