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
        
        let img = #imageLiteral(resourceName: "QuickPayIcon")
        self.addRaisedButton(img, highlightImage: nil, offset: -25.0)
    }
    
    open func insertEmptyTabItem(_ title: String, atIndex: Int) {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)
        vc.tabBarItem.isEnabled = false
        
        self.viewControllers?.insert(vc, at: atIndex)
    }
    
    open func addRaisedButton(_ buttonImage: UIImage?, highlightImage: UIImage?, offset:CGFloat? = nil) {
        if let buttonImage = buttonImage {
            
            let button = UIButton(type: .custom)
            button.autoresizingMask = [UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleTopMargin]
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)

            
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = button.frame.height/2
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1

            button.setBackgroundImage(buttonImage, for: UIControl.State())
            button.setBackgroundImage(highlightImage, for: UIControl.State.highlighted)
            
            let heightDifference = buttonImage.size.height - self.tabBar.frame.size.height
            
            if (heightDifference < 0) {
                button.center = self.tabBar.center
            }
            else {
                var center = self.tabBar.center
                center.y -= heightDifference / 2.0
                
                button.center = center
            }
            
            if offset != nil {
                //Add offset
                var center = button.center
                center.y = center.y + offset!
                button.center = center
            }
            
            button.addTarget(self, action: #selector(CustomTabBarController.onRaisedButton(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func onRaisedButton(_ sender: UIButton!) {
        
    }
}
