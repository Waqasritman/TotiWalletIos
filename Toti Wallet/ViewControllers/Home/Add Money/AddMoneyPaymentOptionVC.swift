//
//  AddMoneyPaymentOptionVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 07/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class AddMoneyPaymentOptionVC: UIViewController {

    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var viewBankAccount: UIView!
    
    var isTableViewVisiable = false
    
    var tableData : [String] = ["check", "check"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        viewWallet.layer.cornerRadius = 8
        btnLoad.layer.cornerRadius = 8
        cardTableView.layer.cornerRadius = 8
        viewBankAccount.layer.cornerRadius = 8
        
        let viewBankAccountGesture = UITapGestureRecognizer(target: self, action: #selector(viewBankAccountFunc(_:)))
        viewBankAccount.addGestureRecognizer(viewBankAccountGesture)
    }
    
    @objc private func viewBankAccountFunc(_ sender: UIGestureRecognizer) {
        
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
    
    @IBAction func btnCrossFunc(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

   
}

extension AddMoneyPaymentOptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardTableCell
        cell.viewMain.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ControllerID.cardDetailVC.instance
        self.pushWithFullScreen(nextVC)
    }
}
