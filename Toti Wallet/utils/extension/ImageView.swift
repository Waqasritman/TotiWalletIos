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
        //  self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
//    convenience init?(barcode: String) {
//        let data = barcode.data(using: .ascii)
//        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
//            return nil
//        }
//        filter.setValue(data, forKey: "inputMessage")
//        guard let ciImage = filter.outputImage else {
//            return nil
//        }
//        self.init(ciImage: ciImage)
//    }
//    
    func fromBase64(strBase64:String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(CGRect(origin: .zero, size: targetSize))
        }
    }
    
}
