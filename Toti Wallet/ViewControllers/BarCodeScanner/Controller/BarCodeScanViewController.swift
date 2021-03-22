//
//  BarCodeScanViewController.swift
//  TalfieIos
//
//  Created by Mohammad Waqas on 7/31/19.
//  Copyright © 2019 Mohammad Waqas. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

public protocol LBXScanViewControllerDelegate: class {
    func scanFinished(scanResult: LBXScanResult, error: String?)
}

public protocol QRRectDelegate {
    func drawwed()
}

class BarCodeScanViewController: BaseVC , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     /**delegation varaible for view controller*/
  //   var viewsDelegate:ViewsTransactionsDelegate!
    open weak var scanResultDelegate: LBXScanViewControllerDelegate?
    
    open var delegate: QRRectDelegate?
    open var scanObj: LBXScanWrapper?
    open var scanStyle: LBXScanViewStyle? = LBXScanViewStyle()
    open var qRScanView: LBXScanView?
    
    open var isOpenInterestRect = false
    public var arrayCodeType:[AVMetadataObject.ObjectType]?
    public  var isNeedCodeImage = false
    public var readyString:String! = "loading"
    
    var topTitle: UILabel?
    
    var isOpenedFlash: Bool = false
    
    var bottomItemsView: UIView?
    
    var btnPhoto: UIButton = UIButton()
    var btnFlash: UIButton = UIButton()
    var btnMyQR: UIButton = UIButton()
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    

    open func setNeedCodeImage(needCodeImg:Bool)
    {
        isNeedCodeImage = needCodeImg;
    }

    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawScanView()
        drawBottomItems()
        perform(#selector(startScan), with: nil, afterDelay: 0.3)
    }
    
    
    
    @IBAction func onBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func drawBottomItems() {
        if (bottomItemsView != nil) {
            return
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame: CGRect(x: 0.0, y: yMax-100, width: self.view.frame.size.width, height: 100 ) )
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        let size = CGSize(width: 65, height: 87)
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/4, y: bottomItemsView!.frame.height/2)
        
        btnFlash.setImage(UIImage(named: "flash_icon"), for:UIControl.State.normal)
        btnFlash.addTarget(self, action: #selector(openOrCloseFlash), for: UIControl.Event.touchUpInside)
        
        
        self.btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPoint(x: bottomItemsView!.frame.width * 3/4, y: bottomItemsView!.frame.height/2)
        btnPhoto.setImage(UIImage(named: "gallery_icon"), for: UIControl.State.normal)
        btnPhoto.setImage(UIImage(named: "gallery_icon"), for: UIControl.State.highlighted)

        
        btnPhoto.addTarget(self, action: #selector(openPhotoAlbum), for: UIControl.Event.touchUpInside)
        

        bottomItemsView?.addSubview(btnFlash)
        bottomItemsView?.addSubview(btnPhoto)
      
        
        
        self.view .addSubview(bottomItemsView!)
        
     let button1 = UIButton(frame: CGRect(x: 16, y: 20, width: 42, height: 42))
       // let button1 = UIButton(frame: CGRect(x: view.frame.size.height, y: view.frame.size.width - 56, width: 60, height: 60))
       button1.setImage(UIImage(named: "backIconWhite"), for: UIControl.State.normal)
        button1.addTarget(self, action: #selector(backButtonPressed), for: UIControl.Event.touchUpInside)
        self.view .addSubview(button1)
    }
    
   

        @objc func backButtonPressed() {
            self.navigationController?.popViewController(animated: true)
    //        navigationController?.popViewController(animated: true)
        }

    @objc func openOrCloseFlash() {
        scanObj?.changeTorch()
        isOpenedFlash = !isOpenedFlash
        if isOpenedFlash {
            btnFlash.setImage(UIImage(named: "flash_icon"), for:UIControl.State.normal)
        } else {
            btnFlash.setImage(UIImage(named: "flash_icon"), for:UIControl.State.normal)
        }
    }
   
    
    @objc open func startScan()
    {
        
        if (scanObj == nil)
        {
            var cropRect = CGRect.zero
            if isOpenInterestRect
            {
                cropRect = LBXScanView.getScanRectWithPreView(preView: self.view, style:scanStyle! )
            }

            if arrayCodeType == nil
            {
                arrayCodeType = [AVMetadataObject.ObjectType.qr as NSString ,AVMetadataObject.ObjectType.ean13 as NSString ,AVMetadataObject.ObjectType.code128 as NSString] as [AVMetadataObject.ObjectType]
            }
            
            scanObj = LBXScanWrapper(videoPreView: self.view,objType:arrayCodeType!, isCaptureImg: isNeedCodeImage,cropRect:cropRect, success: { [weak self] (arrayResult) -> Void in
                
                if let strongSelf = self {
                    strongSelf.qRScanView?.stopScanAnimation()
                    strongSelf.handleCodeResult(arrayResult: arrayResult)
                }
            })
        }
        

        qRScanView?.deviceStopReadying()
        qRScanView?.startScanAnimation()
        scanObj?.start()
    }
    
    open func drawScanView()
    {
        if qRScanView == nil
        {
            qRScanView = LBXScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
            delegate?.drawwed()
        }
        qRScanView?.deviceStartReadying(readyStr: readyString)
        
    }

    open func handleCodeResult(arrayResult:[LBXScanResult])
    {
        if let delegate = scanResultDelegate  {
            
            self.navigationController? .popViewController(animated: true)
            let result:LBXScanResult = arrayResult[0]
            
            delegate.scanFinished(scanResult: result, error: nil)
            
        }else{
            for result:LBXScanResult in arrayResult{
                print("%@",result.strScanned ?? "")
            }
            
            let result:LBXScanResult = arrayResult[0]
            print(result.strScanned!)
            let nextVC = ControllerID.repeatWalletVC.instance
            (nextVC as! RepeatWalletTransactionVC).customerNo = result.strScanned!
            (nextVC as! RepeatWalletTransactionVC).isFromQrCode = true
            self.pushWithFullScreen(nextVC)
           //getting result from camera
          //  let beneficairyDetail = result.strScanned!.split(separator: ",")
      //      BalanceTransferSingleton.shared.isWithOutBeneficiary = true
        //    BalanceTransferSingleton.shared.beneficiaryUserName = String(beneficairyDetail[0])
       //     BalanceTransferSingleton.shared.beneficiaryName = String(beneficairyDetail[1])
        //    BalanceTransferSingleton.shared.beneficiaryAccountNo = String(beneficairyDetail[2])
           // viewsDelegate.moveToTransferDetail()
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        qRScanView?.stopScanAnimation()
        scanObj?.stop()
    }
    
    @objc open func openPhotoAlbum()
    {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var pickedImage : UIImage!
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            pickedImage = img
            
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            pickedImage = img
        }
        //  if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        let detector:CIDetector=CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        
        let ciImage:CIImage = CIImage(image:pickedImage)!
        
        var qrCodeLink = ""
        let features=detector.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            qrCodeLink += feature.messageString!
        }
        
        //GEtting result form image gallery
        dismiss(animated: true, completion: nil)
        print(qrCodeLink)
        let nextVC = ControllerID.repeatWalletVC.instance
        (nextVC as! RepeatWalletTransactionVC).customerNo = qrCodeLink
        (nextVC as! RepeatWalletTransactionVC).isFromQrCode = true
        self.pushWithFullScreen(nextVC)
    
    }
    
    
    
   
    func showMsg(title:String?,message:String?)
    {

        let alertController = UIAlertController(title: nil, message:message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default) { (alertAction) in
            self.startScan()
        }

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
  
}

