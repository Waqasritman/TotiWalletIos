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
    
    let restRepo:RestRepositor = RestRepositor()
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var cameraLbl: UILabel!
    @IBOutlet weak var gallerylbl: UILabel!
    
    let arrayTitle:[String] = ["plz_upload_front_image".localized,"plz_upload_back_image".localized,"plz_upload_customer_image".localized]
    let arrayImage:[String] = ["frontPic" , "back_ic_pic" ,"customer_image"]
    let arrayImageNames:[String] = ["FRONT_IMAGE.jpg" , "BACK_IMAGE.jpg" , "CUSTOMER_IMAGE.jpg"]
    
    
    let arrayError:[String] = ["plz_upload_front_image".localized,"plz_upload_back_image".localized,"plz_upload_customer_image".localized]
    
    var position = 0
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        btnNext.layer.cornerRadius = 8
        
        let viewCameraGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        viewCamera.addGestureRecognizer(viewCameraGesture)
        
        let viewGalleryGesture = UITapGestureRecognizer(target: self, action: #selector(openGallery(_:)))
        viewGallery.addGestureRecognizer(viewGalleryGesture)
        
        
        changeTitleImage(positon: position)
        
        btnNext.setTitle("upload".localized, for: .normal)
        cameraLbl.text = "open_camera".localized
        gallerylbl.text = "choose_from_gallery".localized
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
    
    
    @IBAction func uploadPicture(_ sender: Any) {
        if image != nil {
            if Network.isConnectedToNetwork() {
                showProgress()
                let request = UploadKYCImageRequest()
                request.Customer_No = preferenceHelper.getCustomerNo()
                request.Image_Name = arrayImageNames[position]
                request.Image = image.toBase64()!
                request.credentials.LanguageID = Int(preferenceHelper.getApiLangugae())!
                print(request.toJSON())
                restRepo.uploadKYCImage(param: request.toJSON(), completion: {(response , error ) in
                    self.hideProgress()
                    if let error = error {
                        self.showError(message: error.localizedDescription)
                    } else if response!.ResponseCode == 101 {
                        self.showSuccess(message: response!.Description)
                        self.position += 1
                        if self.position < 3 {
                            self.changeTitleImage(positon: self.position)
                        } else {
                            let nextVC = ControllerID.completedKYCVC.instance
                            self.pushWithFullScreen(nextVC)
                        }
                        
                    } else {
                        self.showError(message: response!.Description)
                    }
                })
                
            }
        } else {
            if self.position < 3 {
                self.showError(message: arrayError[position])
            }
        }
        
    }
    
    
    // MARK:- Choose Photos
    func choosePhotoResource(source: String) {
        if source == "library" {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            present(self.imagePicker, animated: false, completion: nil)
        }else{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                present(self.imagePicker, animated: false, completion: nil)
            }else{
                self.showError(message: "Camera preview not available")
            }
        }
    }
    
    
    func changeTitleImage(positon:Int) {
        lblTitle.text = arrayTitle[position]
        imgOutlet.image = UIImage(named: arrayImage[position])
    }
    
}
//MARK:- UIImagePickerControllerDelegate Methods
extension CardPicVC:UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //   var image : UIImage!
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = img
            
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = img
        }
      
       // image = UIImageView().resize(targetSize: CGSize(width: 300, height: 300))
        
        
        let stirng = convertImageToBase64String(img: image)
        
        imgOutlet.image = convertBase64StringToImage(imageBase64String: stirng)
        
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
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
        imgOutlet.image = newImage
       // let date = Date()
       // let formatter = DateFormatter()
       // formatter.dateFormat = "ddMMyyyyhhmmss"
       // let result: String = formatter.string(from: date)
        
        
        
     //   let strImageName = String(format: "%@.jpg",result)
        self.dismiss(animated: false, completion: nil)
    }
}


