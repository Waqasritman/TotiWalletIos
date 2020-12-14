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
        
        self.addRaisedButton()
    }
    
    open func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = ControllerID.quickPayVC.instance
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.isEnabled = false
        
        self.viewControllers?.insert(vc, at: atIndex)
    }
    
    open func addRaisedButton(_ buttonImage: UIImage?, highlightImage: UIImage?, offset:CGFloat? = nil) {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.white
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(#imageLiteral(resourceName: "QuickPayIcon") , for: .normal)
        menuButton.addTarget(self, action: #selector(onRaisedButton(_:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc func onRaisedButton(_ sender: UIButton!) {
        self.selectedIndex = 2
    }
}
