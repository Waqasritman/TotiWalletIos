//
//  CashNetworkAgentsVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 1/9/21.
//  Copyright © 2021 iOS Technologies. All rights reserved.
//

import UIKit

class CashNetworkAgentsVC: BaseVC {

    @IBOutlet weak var searchTableView: UITableView!

    @IBOutlet weak var toolTitle: UILabel!
    var filteredList:[CashNetworks] = Array()
    
    
    var delegate:OnSelectCashAgent!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        toolTitle.text = "select_city_txt".localized
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK : TableView Functions
extension CashNetworkAgentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].payOutAgent
       
            cell.lblDetail.text = ""
        
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectCashAgent(agent: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}

