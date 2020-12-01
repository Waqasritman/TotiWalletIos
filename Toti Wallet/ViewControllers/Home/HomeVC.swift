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

class HomeVC: UIViewController {

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
        
    }
    
    @IBAction func btnBarCodeFunc(_ sender: UIButton) {
//        let viewController = BarcodeScannerViewController()
//        viewController.codeDelegate = self
//        viewController.errorDelegate = self
//        viewController.dismissalDelegate = self
//        self.presentWithFullScreen(viewController)
    }

    @objc private func addMoneyFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    @objc private func moneyTransferFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    @objc private func currencyConverterFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    @objc private func mobileTopUpFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    @objc private func billPaymentsFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    @objc private func prepaidCardFunc(_ sender: UIGestureRecognizer) {
    
    }
    
    
}

// MARK: CollectionView Functions
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RateCollectionCell", for: indexPath) as! RateCollectionCell
            cell.viewMain.layer.cornerRadius = 10
            cell.shadowDecorate()
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
