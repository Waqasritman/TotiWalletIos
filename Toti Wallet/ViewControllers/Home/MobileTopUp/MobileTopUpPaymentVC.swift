//
//  MobileTopUpPaymentVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 10/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class MobileTopUpPaymentVC: BaseVC {
    
    let repo:UtilityRepository = UtilityRepository()
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var btnProcced: UIButton!
    
    var isTableViewVisiable = false
    
    var tableData : [String] = ["check", "check"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        btnLoad.layer.cornerRadius = 8
        btnWallet.layer.cornerRadius = 8
        
        btnWallet.imageEdgeInsets.left = self.view.frame.width - 80
        
        btnProcced.layer.cornerRadius = 8
    }
    
    
    @IBAction func btnPayFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLoadFunc(_ sender: UIButton) {
        if isTableViewVisiable {
            cardTableView.isHidden = false
            isTableViewVisiable = false
        }
        else{
            cardTableView.isHidden = true
            isTableViewVisiable = true
        }
    }
    
    @IBAction func btnProccedFunc(_ sender: UIButton) {
        let nextVC = ControllerID.mobileTopUpSuccessVC.instance
        self.pushWithFullScreen(nextVC)
    }
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        if let destinationViewController = navigationController?.viewControllers
            .filter(
                {$0 is CustomTabBarController})
            .first {
            navigationController?.popToViewController(destinationViewController, animated: true)
        }
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK : TableView Functions
extension MobileTopUpPaymentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
