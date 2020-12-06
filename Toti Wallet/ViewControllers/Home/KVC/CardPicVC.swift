//
//  CardPicVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class CardPicVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 8
        
        let viewCameraGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        viewCamera.addGestureRecognizer(viewCameraGesture)
        
        let viewGalleryGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        viewGallery.addGestureRecognizer(viewGalleryGesture)
        
    }
    

    @objc func openCamera(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func openGallery(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
