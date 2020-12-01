//
//  ImageView.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 11/30/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
extension UIImageView {
    
    func makeImageCircle() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}
