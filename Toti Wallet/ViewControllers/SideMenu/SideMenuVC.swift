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
    
    let sideTableData = ["Business Transaction", "Change PIN", "My Beneficiary List", "Pay via QR Code", "My QR Code", "Bill Payment", "Loyalty Points" ,"Refer to Friends", "Settings", "Logout"]
    
    let sideTableImages = [UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "SideMenuQRCode"), UIImage(named: "sideMenuQRCode2"), UIImage(named: "sideMenuBill"), UIImage(named: "sideMenuLoyalty"), UIImage(named: "sideMenuShare"), UIImage(named: "sideMenuInfo") ,UIImage(named: "sideMenuLogout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideTableView.delegate = self
        sideTableView.dataSource = self
        
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
        else if sideTableData[indexPath.row] == "My Beneficiary List"{
            let nextVC = ControllerID.beneficiaryListVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Pay via QR Code"{
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
        else if sideTableData[indexPath.row] == "My QR Code" {
            let nextVC = ControllerID.myQRCode.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Bill Payment" {
            let nextVC = ControllerID.billPaymentVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Loyalty Points"{
            let nextVC = ControllerID.loyaltyPointsVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Refer to Friends"{
            let nextVC = ControllerID.shareWthFriendVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Settings"{
            let nextVC = ControllerID.settingsVC.instance
            self.pushWithFullScreen(nextVC)
        }
        else if sideTableData[indexPath.row] == "Logout"{
            
        }
    }
    
    
    
    func goToEditProfile() {
        if preferenceHelper.getISKYCApproved() {
            let nextVC = ControllerID.editProfileVC.instance
            self.pushWithFullScreen(nextVC)
        } else {
            self.showError(message: "KYC error")
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

