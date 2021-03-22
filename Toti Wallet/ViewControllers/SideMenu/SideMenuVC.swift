//
//  SideMenuVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 29/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SideMenu
import BarcodeScanner

class SideMenuVC: BaseVC {
    
    @IBOutlet weak var sideTableView: UITableView!
    
    let sideTableData = ["swift_transfer".localized, "change_pin".localized, "my_bene_list".localized, "pay_via_qr_code".localized, "my_qr_code".localized, "bill_payment_vc".localized, "loyalty_points_txt".localized ,"refer_to_friends".localized, "settings".localized, "logout_txt".localized]
    
    let sideTableImages = [UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "sideMenuQRCode2"), UIImage(named: "sideMenuBill"), UIImage(named: "sideMenuLoyalty"), UIImage(named: "sideMenuShare"), UIImage(named: "sideMenuInfo") ,UIImage(named: "sideMenuLogout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideTableView.delegate = self
        sideTableView.dataSource = self

    }
    
    override func handleAction(action: Bool) {
        if action {
            
            let nextVC = ControllerID.loginSignUpOptionVC.instance
            self.pushWithFullScreen(nextVC)
            
//            for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: LoginSignUpOptionVC.self) {
//                        _ =  self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
         
        } else {
            
        }
    }
    
}

//MARK : TableView Functions
extension SideMenuVC: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell2")
        cell?.textLabel?.text = sideTableData[indexPath.row]
        cell?.imageView?.image = sideTableImages[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! HeaderTableCell
        headerCell.btnImage.layer.cornerRadius = headerCell.btnImage.frame.height/2
        headerCell.lblImage.text = preferenceHelper.getCustomerName()
        if  preferenceHelper.getUserImage() != "" {
            headerCell.btnImage.image = fromBase64(strBase64: preferenceHelper.getUserImage())
        }
        headerCell.btnEdit.setTitle("edit_profile_txt".localized, for: .normal)
        headerCell.initView(sideMenu: self)
        return headerCell
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let nextVC = ControllerID.businessTranscationVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 1 {
            let nextVC = ControllerID.changePinVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 2{
            let nextVC = ControllerID.beneficiaryListVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 3{
//            let viewController = BarcodeScannerViewController()
//            viewController.codeDelegate = self
//            viewController.errorDelegate = self
//            viewController.dismissalDelegate = self
//            self.presentWithFullScreen(viewController)
            var style = LBXScanViewStyle()
            style.centerUpOffset = 44
            style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On
            style.photoframeLineW = 6
            style.photoframeAngleW = 24
            style.photoframeAngleH = 24
            style.isNeedShowRetangle = true
                   
            style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
            style.animationImage = UIImage(named: "qrcode_scan_part_net")
            let nextVC = ControllerID.barCodeScanner.instance
            (nextVC as! BarCodeScanViewController).scanStyle = style
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 4 {
            let nextVC = ControllerID.myQRCode.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 5 {
//            let nextVC = ControllerID.billPaymentVC.instance
//            self.pushWithFullScreen(nextVC)
            let nextVC = ControllerID.loyaltyPointsVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 6 {
            let nextVC = ControllerID.loyaltyPointsVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 7 {
            let nextVC = ControllerID.shareWthFriendVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 8 {
            let nextVC = ControllerID.settingsVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if indexPath.row == 9 {
            AlertView.instance.delegate = self
            
            AlertView.instance.showAlert(title: "logout_txt".localized, message: "logout_message".localized, hide: false)
        }
    }
    
    
    
    func goToEditProfile() {
        if preferenceHelper.getISKYCApproved() {
            let nextVC = ControllerID.editProfileVC.instance
            self.pushWithFullScreen(nextVC)
        } else {
            self.showError(message: "plz_complete_kyc".localized)
        }
       
    }
    
    
 
    
    
}

extension SideMenuVC: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {

    }

    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {

    }

    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

