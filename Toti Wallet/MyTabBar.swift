//
//  MyTabBar.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 15/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    private var middleButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMiddleButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = middleButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
    }
    
    func setupMiddleButton() {
        middleButton.frame.size = CGSize(width: 60, height: 60)
        middleButton.setImage(#imageLiteral(resourceName: "QuickPayIcon"), for: .normal)
        middleButton.backgroundColor = UIColor.white
        middleButton.layer.cornerRadius = 30
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        middleButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        addSubview(middleButton)
    }
    
    @objc func test() {
        print("my name is jeff")
    }

}
