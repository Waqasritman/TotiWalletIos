//
//  SelectWalletVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class SelectWalletVC: UIViewController {

    @IBOutlet weak var walletCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        walletCollectionView.delegate = self
        walletCollectionView.dataSource = self
        
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: CollectionView Functions
extension SelectWalletVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RateCollectionCell", for: indexPath) as! RateCollectionCell
        cell.viewMain.layer.cornerRadius = 10
        cell.shadowDecorate()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = ControllerID.addMoneyVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.height)
        
    }
}
