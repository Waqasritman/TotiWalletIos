//
//  CardPicVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 06/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import TOCropViewController
class CardPicVC: BaseVC, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnNext.layer.cornerRadius = 8
        
        let viewCameraGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        viewCamera.addGestureRecognizer(viewCameraGesture)
        
        let viewGalleryGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        viewGallery.addGestureRecognizer(viewGalleryGesture)
        
    }
    

    @objc func openCamera(_ sender: UITapGestureRecognizer) {
        choosePhotoResource(source: "camera")
    }
    
    @objc func openGallery(_ sender: UITapGestureRecognizer) {
        choosePhotoResource(source: "library")
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- Choose Photos
    func choosePhotoResource(source: String) {
        if source == "library" {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            present(self.imagePicker, animated: false, completion: nil)
        }else{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                present(self.imagePicker, animated: false, completion: nil)
            }else{
                self.showError(message: "Camera preview not available")
            }
        }
    }

}
//MARK:- UIImagePickerControllerDelegate Methods
extension CardPicVC:UIImagePickerControllerDelegate {
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chooseimage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        dismiss(animated: true, completion: nil)
        
        openTOCropViewController(image: chooseimage!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    //MARK:- Open Crop ViewController
    func openTOCropViewController(image: UIImage) {
        
        let cropController = TOCropViewController(croppingStyle:  .default, image: image)
        cropController.view.backgroundColor = UIColor.clear
        cropController.toolbar.resetButton.isHidden = true
        cropController.aspectRatioLockEnabled = true
        cropController.customAspectRatio = CGSize(width: Utility.ScreenSize.SCREEN_WIDTH, height: Utility.ScreenSize.SCREEN_HEIGHT/2)
        cropController.resetAspectRatioEnabled = false
        cropController.rotateButtonsHidden = false
        cropController.rotateClockwiseButtonHidden = false
        cropController.modalTransitionStyle = .crossDissolve
        cropController.delegate = self
        
        self.present(cropController, animated: false, completion: nil)
    }
}
//MARK :- Cropper Delegate
extension CardPicVC: TOCropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        
        let newImage = Utility.resizeImage(image, newWidth: Utility.ScreenSize.SCREEN_WIDTH)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyhhmmss"
        let result: String = formatter.string(from: date)
       
        imgOutlet.image = newImage
 
        let strImageName = String(format: "%@.jpg",result)
        print(strImageName)
        self.dismiss(animated: false, completion: nil)
        
    }
}


