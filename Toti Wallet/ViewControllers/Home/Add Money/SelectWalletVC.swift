//
//  SelectWalletVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SelectWalletVC: BaseVC {
    let authRepo = AuthRepository()
    @IBOutlet weak var walletCollectionView: UICollectionView!
    var walletList:[CustomerWalletDetails] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        walletCollectionView.delegate = self
        walletCollectionView.dataSource = self
      getCustomerWallets()
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
    
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
                    self.walletCollectionView.reloadData()
                    self.preferenceHelper.isWalletNeedToUpdate(isNeed: false);
                } else {
                    self.showError(message: response!.description)
                }
            })
        } else {
            self.noInternet()
        }
        
        
    }
    
    
}

// MARK: CollectionView Functions
extension SelectWalletVC: UICollectionViewDelegate, UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return walletList.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RateCollectionCell", for: indexPath) as! RateCollectionCell
            cell.viewMain.layer.cornerRadius = 10
            cell.walletName.text = walletList[indexPath.row].currencyFullName + " " + "(\(String(describing: walletList[indexPath.row].currencyShortName!)))"
            cell.walletBalance.text =  walletList[indexPath.row].balance
            cell.image.sd_setImage(with: URL(string: walletList[indexPath.row].imageURL), placeholderImage: UIImage(named: "flag"))
            cell.image.makeImageCircle()
            cell.viewMain.dropShadow()
            return cell
     

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = ControllerID.addMoneyVC.instance
        LoadWalletRequest.shared.walletCurrency = walletList[indexPath.row].currencyShortName
        self.pushWithFullScreen(nextVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.height)
        
    }
}
