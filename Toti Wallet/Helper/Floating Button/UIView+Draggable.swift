//
//  UIView+Draggable.swift
//
//  Created by Yehia Elbehery on 1/10/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import UIKit

extension UIView {
    func addDragging(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func draggedAction(_ pan:UIPanGestureRecognizer){
        
        let translation = pan.translation(in: self.superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    
    func takeScreenshot() -> UIImage {

            // Begin context
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

            // Draw view in that context
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)

            // And finally, get image
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            if (image != nil)
            {
                return image!
            }
            return UIImage()
        }
}
