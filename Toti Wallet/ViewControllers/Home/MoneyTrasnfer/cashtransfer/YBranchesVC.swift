//
//  YBranchesVC.swift
//  Toti Wallet
//
//  Created by Mohammad Waqas on 12/5/20.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class YBranchesVC: BaseVC {
    
   
    @IBOutlet weak var searchTableView: UITableView!

    
    @IBOutlet weak var pageTitle: UILabel!
  
    var filteredList:[YBranches] = Array()
    
    
    var delegate:YBranchesProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchTableView.delegate = self
        searchTableView.dataSource = self
        pageTitle.text = "select_location_txt".localized
    }
    

    @IBAction func btnBackFunc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : TableView Functions
extension YBranchesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CountryTableCell
        cell.lblTitle.text = filteredList[indexPath.row].branchName
       
            cell.lblDetail.text = ""
        
        cell.imageOutlet.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectBranch(branch: filteredList[indexPath.row])
        self.btnBackFunc(self)
    }
}
