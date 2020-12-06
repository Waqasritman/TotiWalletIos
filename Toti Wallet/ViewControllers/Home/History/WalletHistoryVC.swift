
//
//  WalletHistoryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 05/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class WalletHistoryVC: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnReceived: UIButton!
    @IBOutlet weak var btnPaid: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
    }
    
    @IBAction func btnAllFunc(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.viewBar.frame = CGRect(x: self.btnAll.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
        }, completion: { (finished: Bool) -> Void in
        })
    }
    
    
    @IBAction func btnReceivedFunc(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.viewBar.frame = CGRect(x: self.btnReceived.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
        }, completion: { (finished: Bool) -> Void in
        })
    }
    
    @IBAction func btnPaidFunc(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.viewBar.frame = CGRect(x: self.btnPaid.frame.origin.x , y: self.viewBar.frame.origin.y, width: self.viewBar.frame.size.width ,height: 2)
        }, completion: { (finished: Bool) -> Void in
        })
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK : TableView Functions
extension WalletHistoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell") as! HistoryTableCell
        cell.viewMain.layer.cornerRadius = 12
        cell.viewMain.dropShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

