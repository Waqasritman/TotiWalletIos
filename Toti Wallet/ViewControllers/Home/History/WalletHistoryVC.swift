
//
//  WalletHistoryVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 05/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class WalletHistoryVC: BaseVC {

    let repos:Repository = Repository()
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnReceived: UIButton!
    @IBOutlet weak var btnPaid: UIButton!
    @IBOutlet weak var viewPaid: UIView!
    
    @IBOutlet weak var viewReceived: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    
    var list:[WalletHistory] = []
    var filteredList:[WalletHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageTitle.text = "wallet_history".localized
        btnAll.setTitle("all_text".localized, for: .normal)
        btnReceived.setTitle("received_text".localized, for: .normal)
        btnPaid.setTitle("paid_text".localized, for: .normal)
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        getWalletHistory()
    }
    
    @IBAction func btnAllFunc(_ sender: UIButton) {

        viewBar.isHidden = false
        viewReceived.isHidden = true
        viewPaid.isHidden = true
        filteredList.removeAll()
        filteredList.append(contentsOf: list)
        historyTableView.reloadData()
    }
    
    
    @IBAction func btnReceivedFunc(_ sender: UIButton) {

        viewBar.isHidden = true
        viewReceived.isHidden = false
        viewPaid.isHidden = true
        filteredList.removeAll()
        for history in list {
            if history.status.lowercased().elementsEqual("received") {
                filteredList.append(history)
            }
        }
        historyTableView.reloadData()
        
    }
    
    @IBAction func btnPaidFunc(_ sender: UIButton) {

        viewBar.isHidden = true
        viewReceived.isHidden = true
        viewPaid.isHidden = false
        filteredList.removeAll()
        for history in list {
            if history.status.lowercased().elementsEqual("paid") {
                filteredList.append(history)
            }
        }
        historyTableView.reloadData()
    }
    
    
    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getWalletHistory() {
        if Network.isConnectedToNetwork() {
            let request = WalletHistoryRequest()
            request.customerNo = preferenceHelper.getCustomerNo()
            request.languageId  = preferenceHelper.getLanguage()
            showProgress()
            repos.getWalletTransHistory(request: HTTPConnection.openConnection(stringParams: request.getXML(), action: SoapActionHelper.shared.ACTION_WALLET_HISTORY), completion: {(response , error ) in
                self.hideProgress()
                if let error = error {
                    self.showError(message: error)
                } else if response!.responseCode == 101 {
                    self.list.removeAll()
                    self.filteredList.removeAll()
                    
                    self.list.append(contentsOf: response!.walletHistoryList)
                    self.filteredList.append(contentsOf: response!.walletHistoryList)
                    self.historyTableView.reloadData()
                } else {
                    self.showError(message: response!.description!)
                }
            })
        } else {
            
        }
    }

}

//MARK : TableView Functions
extension WalletHistoryVC: UITableViewDataSource, UITableViewDelegate , RepeatDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell") as! HistoryTableCell
        cell.viewMain.layer.cornerRadius = 10
        cell.viewMain.dropShadow()
        cell.btnReceipt.setTitle("repeat_txt".localized, for: .normal)
        cell.btnReceipt.layer.cornerRadius = 5
        cell.walletDelegate = self
        cell.setWalletHistoryData(history: filteredList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func onClickRepeat(history: WalletHistory) {
        let nextVC = ControllerID.repeatWalletVC.instance
        (nextVC as! RepeatWalletTransactionVC).history = history
        self.pushWithFullScreen(nextVC)
    }
}

