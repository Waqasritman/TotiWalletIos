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
    @IBOutlet weak var btnProfileImage: UIImageView!
    @IBOutlet weak var rateCollectionView: UICollectionView!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var offerlbl: UILabel!
    @IBOutlet weak var btnRegistration: UIButton!
    @IBOutlet weak var viewAddMoney: UIView!
    @IBOutlet weak var viewMoneyTransfer: UIView!
    @IBOutlet weak var viewConvertyCurrency: UIView!
    @IBOutlet weak var viewMobileTopUp: UIView!
    @IBOutlet weak var viewBillPayments: UIView!
    @IBOutlet weak var viewPrepaidCards: UIView!
    
    @IBOutlet weak var createWalletView: UIView!
    @IBOutlet weak var transactionHistoryView: UIView!
    @IBOutlet weak var walletHistoryView: UIView!
    
    var walletList:[CustomerWalletDetails] = Array()
    
    @IBOutlet weak var createWalletLbl: UILabel!
    @IBOutlet weak var addMoneylbl: UILabel!
    @IBOutlet weak var moneyTransferlbl: UILabel!
    @IBOutlet weak var prepaidlbl: UILabel!
    
    @IBOutlet weak var billPaymentlbl: UILabel!
    @IBOutlet weak var mobileTopuplbl: UILabel!
    @IBOutlet weak var ownWalletlbl: UILabel!
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var transactionHstLBL: UILabel!
    
    @IBOutlet weak var walletHStlbl: UILabel!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuWidth = self.view.frame.width/2 + 100
        SideMenuManager.default.menuDismissOnPush = true
        SideMenuManager.default.menuFadeStatusBar = false
        
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
        transactionHistoryView.layer.cornerRadius = 8
        walletHistoryView.layer.cornerRadius = 8
        createWalletView.layer.cornerRadius = 8
        
        transactionHistoryView.dropShadow()
        walletHistoryView.dropShadow()
        createWalletView.dropShadow()
        
        viewAddMoney.dropShadow()
        viewMoneyTransfer.dropShadow()
        viewConvertyCurrency.dropShadow()
        viewMobileTopUp.dropShadow()
        viewBillPayments.dropShadow()
        viewPrepaidCards.dropShadow()
        
        
        createWalletLbl.text = "create_wallet".localized
        transactionHstLBL.text = "transaction_history_break".localized
        walletHStlbl.text = "wallet_history_break".localized
        
        offerlbl.text = "offer_of_home".localized
        addMoneylbl.text = "add_moeny_txt".localized
        moneyTransferlbl.text = "money_transfer".localized
        ownWalletlbl.text = "convert_currency_home".localized
        mobileTopuplbl.text = "mobile_top_up_home".localized
        billPaymentlbl.text = "biller_name_home".localized
        prepaidlbl.text = "prepaid_card_home".localized
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
        
        
        let viewCreateWalletGesture = UITapGestureRecognizer(target: self, action: #selector(createWalletFunc(_:)))
        createWalletView.addGestureRecognizer(viewCreateWalletGesture)
        
        let viewTransactionHistoryGesture = UITapGestureRecognizer(target: self, action: #selector(transactionHistory(_:)))
        transactionHistoryView.addGestureRecognizer(viewTransactionHistoryGesture)
        
        let viewWalletHistoryGesture = UITapGestureRecognizer(target: self, action: #selector(walletHistory(_:)))
        walletHistoryView.addGestureRecognizer(viewWalletHistoryGesture)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshControl.tintColor = UIColor.black
        
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        scrollViewOutlet.isScrollEnabled = true
        scrollViewOutlet.alwaysBounceVertical = true
        scrollViewOutlet.addSubview(refreshControl)
        
        
        if preferenceHelper.getIsWalletNeedToUpdate() {
            getCustomerWallets()
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        refreshControl.endRefreshing()
        getCustomerWallets()
    }
    
    @IBAction func btnRegistrationFunc(_ sender: Any) {
        let nextVC = ControllerID.completeRegistrationVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        print(preferenceHelper.getUserImage())
        
        btnProfileImage.makeImageCircle()
        if  preferenceHelper.getUserImage() != "" {
            btnProfileImage.image = fromBase64(strBase64: preferenceHelper.getUserImage())
        }
        if !preferenceHelper.getISKYCApproved() {
            if preferenceHelper.getDocumentUploaded() {
                btnRegistration.isHidden = true
            } else {
                btnRegistration.isHidden = false
                AlertView.instance.showAlert(title: "complete_profile".localized , message: "please_complete_kyc".localized)
            }
        } else {
            btnRegistration.isHidden = true
        }
        
    }
    
    
    
    @IBAction func btnBarCodeFunc(_ sender: UIButton) {
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
    
    @IBAction func btnNotificationFunc(_ sender: UIButton) {
        let nextVC = ControllerID.notificationListVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    @objc private func createWalletFunc(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.createWallet.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func transactionHistory(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.transactionHistoryVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func walletHistory(_ sender: UIGestureRecognizer) {
        let nextVC = ControllerID.walletHistoryVC.instance
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
        let nextVC = ControllerID.walletTransferVC.instance
        (nextVC as! WalletTransferVC).isOwnWallet = true
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func mobileTopUpFunc(_ sender: UIGestureRecognizer) {
        //        let nextVC = ControllerID.mobileTopUpVC.instance
        //        self.pushWithFullScreen(nextVC)
        
        let nextVC = ControllerID.loyaltyPointsVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func billPaymentsFunc(_ sender: UIGestureRecognizer) {
        //        let nextVC = ControllerID.billPaymentVC.instance
        //        self.pushWithFullScreen(nextVC)
        
        let nextVC = ControllerID.loyaltyPointsVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @objc private func prepaidCardFunc(_ sender: UIGestureRecognizer) {
        //        let nextVC = ControllerID.prepardCardVC.instance
        //        self.pushWithFullScreen(nextVC)
        
        let nextVC = ControllerID.loyaltyPointsVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    
    override func handleAction(action: Bool) {
        if action {
            self.btnRegistrationFunc(self)
        }
    }
    
    
}

// MARK: CollectionView Functions
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func getCustomerWallets() {
        
        if Network.isConnectedToNetwork() {
            showProgress()
            let request = GetCustomerWalletDetailsRequest()
            request.languageId = preferenceHelper.getApiLangugae()
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
                    preferenceHelper.isWalletNeedToUpdate(isNeed: false);
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
            cell.balancelbl.text = "balance_text".localized
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            
        }else {
            let nextVC = ControllerID.loyaltyPointsVC.instance
            self.pushWithFullScreen(nextVC)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.height)
        }
        else{
            return CGSize(width: 150, height: 100)
        }
        
    }
}
