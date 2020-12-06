//
//  HomeVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 28/11/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit
import SideMenu
//import BarcodeScanner

class HomeVC: BaseVC {
    let authRepo:AuthRepository = AuthRepository()
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var rateCollectionView: UICollectionView!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var btnRegistration: UIButton!
    @IBOutlet weak var viewAddMoney: UIView!
    @IBOutlet weak var viewMoneyTransfer: UIView!
    @IBOutlet weak var viewConvertyCurrency: UIView!
    @IBOutlet weak var viewMobileTopUp: UIView!
    @IBOutlet weak var viewBillPayments: UIView!
    @IBOutlet weak var viewPrepaidCards: UIView!
    
    
    var walletList:[CustomerWalletDetails] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuWidth = self.view.frame.width/2 + 100
        SideMenuManager.default.menuDismissOnPush = true
        
        btnProfileImage.layer.cornerRadius = btnProfileImage.frame.height/2
        rateCollectionView.delegate = self
        rateCollectionView.dataSource = self
        
        offerCollectionView.delegate = self
        offerCollectionView.dataSource = self
        
        btnRegistration.layer.cornerRadius = 8
        btnRegistration.layer.borderWidth = 1
        btnRegistration.layer.borderColor = #colorLiteral(red: 0.5759999752, green: 0.1140000001, blue: 0.3330000043, alpha: 1)
        btnRegistration.imageEdgeInsets.left = self.view.frame.width - 50
        
        viewBottom.layer.cornerRadius = 16
        viewBottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewAddMoney.layer.cornerRadius = 8
        viewMoneyTransfer.layer.cornerRadius = 8
        viewConvertyCurrency.layer.cornerRadius = 8
        viewMobileTopUp.layer.cornerRadius = 8
        viewBillPayments.layer.cornerRadius = 8
        viewPrepaidCards.layer.cornerRadius = 8
        
        viewAddMoney.dropShadow()
        viewMoneyTransfer.dropShadow()
        viewConvertyCurrency.dropShadow()
        viewMobileTopUp.dropShadow()
        viewBillPayments.dropShadow()
        viewPrepaidCards.dropShadow()
        
        let viewAddMoneyGesture = UITapGestureRecognizer(target: self, action: #selector(addMoneyFunc(_:)))
        viewAddMoney.addGestureRecognizer(viewAddMoneyGesture)
        
        let viewMoneyTransferGesture = UITapGestureRecognizer(target: self, action: #selector(moneyTransferFunc(_:)))
        viewMoneyTransfer.addGestureRecognizer(viewMoneyTransferGesture)
        
        let viewConvertyCurrencyGesture = UITapGestureRecognizer(target: self, action: #selector(currencyConverterFunc(_:)))
        viewConvertyCurrency.addGestureRecognizer(viewConvertyCurrencyGesture)
        
        let viewMobileTopUpGesture = UITapGestureRecognizer(target: self, action: #selector(mobileTopUpFunc(_:)))
        viewMobileTopUp.addGestureRecognizer(viewMobileTopUpGesture)
        
        let viewBillPaymentsGesture = UITapGestureRecognizer(target: self, action: #selector(billPaymentsFunc(_:)))
        viewBillPayments.addGestureRecognizer(viewBillPaymentsGesture)
        
        let viewPrepaidCardsGesture = UITapGestureRecognizer(target: self, action: #selector(prepaidCardFunc(_:)))
        viewPrepaidCards.addGestureRecognizer(viewPrepaidCardsGesture)
        
        
        if self.preferenceHelper.getIsWalletNeedToUpdate() {
            getCustomerWallets()
        }
        
        AlertView.instance.showAlert(title: "Compelete your profile".localiz() , message: "Please Compelte your Registration")
        
    }
    
    @IBAction func btnRegistrationFunc(_ sender: UIButton) {
        let nextVC = ControllerID.completeRegistrationVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        print(preferenceHelper.getUserImage())
        
        
        if preferenceHelper.getIsDocumentUploaded() {
            btnRegistration.isHidden = true
        } else {
            btnRegistration.isHidden = false
        }
        
        if preferenceHelper.getISKYCApproved() {
            btnRegistration.isHidden = true
        } else {
            if !preferenceHelper.getIsDocumentUploaded() {
                btnRegistration.isHidden = false
            } else {
                btnRegistration.isHidden = true
            }
            
        }
    }
    
    @IBAction func btnBarCodeFunc(_ sender: UIButton) {
        //        let viewController = BarcodeScannerViewController()
        //        viewController.codeDelegate = self
        //        viewController.errorDelegate = self
        //        viewController.dismissalDelegate = self
        //        self.presentWithFullScreen(viewController)
    }
    
    @IBAction func btnNotificationFunc(_ sender: UIButton) {
        let nextVC = ControllerID.notificationListVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func addMoneyFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.selectWalletVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func moneyTransferFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.quickPayVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func currencyConverterFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.ourRatesVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func mobileTopUpFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.mobileTopUpVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func billPaymentsFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.billPaymentVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func prepaidCardFunc(_ sender: UIGestureRecognizer) {
        
    }
    
    
}

// MARK: CollectionView Functions
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func getCustomerWallets() {
        
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetCustomerWalletDetailsRequest()
            request.languageId = "1"
            request.customerNo = preferenceHelper.getCustomerNo()
            request.mobileNumber  = ""
            
            authRepo.getCustomerWalletDetails(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_GET_CUSTOMER_WALLET), completion: {(response , error) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.walletList.removeAll()
                    self.walletList.append(contentsOf: response!.walletList)
                    self.rateCollectionView.reloadData()
                    self.preferenceHelper.isWalletNeedToUpdate(isNeed: false);
                } else {
                    self.showError(message: response!.description)
                }
            })
        } else {
            self.noInternet()
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return walletList.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RateCollectionCell", for: indexPath) as! RateCollectionCell
            cell.viewMain.layer.cornerRadius = 10
            cell.walletName.text = walletList[indexPath.row].currencyFullName + " " + "(\(String(describing: walletList[indexPath.row].currencyShortName!)))"
            cell.walletBalance.text =  walletList[indexPath.row].balance
            cell.image.sd_setImage(with: URL(string: walletList[indexPath.row].imageURL), placeholderImage: UIImage(named: "flag"))
            cell.image.makeImageCircle()
            cell.viewMain.dropShadow()
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath)
            cell.layer.cornerRadius = 8
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.height)
        }
        else{
            return CGSize(width: 150, height: 80)
        }
        
    }
}

//extension HomeVC: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
//
//    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
//
//    }
//
//    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
//
//    }
//
//    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//}
