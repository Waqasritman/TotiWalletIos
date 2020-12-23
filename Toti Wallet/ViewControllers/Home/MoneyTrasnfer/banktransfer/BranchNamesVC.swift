//
//  BranchNamesVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/8/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BranchNamesVC: BaseVC {


    @IBOutlet weak var toolTitle: UILabel!
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
        }
    }
    
    
   
    var filteredList:[BankNetwork]!
    
    
    var delegate:BankNetworkProtocol!
    var payOutCountry:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolTitle.text = "select_bank".localized
        searchTableView.reloadData()
    }
  

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//MARK : TableView Functions
extension BranchNamesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].branchName
        cell.lblDetail.text = ""
        cell.imageView?.image = nil
        cell.imageView!.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectBankNetwork(network:filteredList[indexPath.row])
        self.btnBackFunc(self)
    }

}
