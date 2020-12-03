//
//  BarcodeGenerator.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/2/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
class BarcodeGenerator {
  
    
    enum Descriptor: String {
        case code128 = "CICode128BarcodeGenerator"
        case pdf417 = "CIPDF417BarcodeGenerator"
        case aztec = "CIAztecCodeGenerator"
        case qr = "CIQRCodeGenerator"
    }
    
    
    
    func generateCode(data:String) {
        let data = data.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        let processedImage = UIImage(cgImage: cgImage)
    }
    
    
    
    
    class func generate(from string: String,
                        descriptor: Descriptor,
                        size: CGSize) -> CIImage? {
        let filterName = descriptor.rawValue
        
        guard let data = string.data(using: .ascii),
              let filter = CIFilter(name: filterName) else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        
        guard let image = filter.outputImage else {
            return nil
        }
        
        let imageSize = image.extent.size
        
        let transform = CGAffineTransform(scaleX: size.width / imageSize.width,
                                          y: size.height / imageSize.height)
        let scaledImage = image.transformed(by: transform)
        
        return scaledImage
    }
}
