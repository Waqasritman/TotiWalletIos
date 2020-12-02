//
//  BeneficiaryListVC.swift
//  Toti Wallet
//
//  Created by Adnan Yousaf on 02/12/2020.
//  Copyright © 2020 iOS Technologies. All rights reserved.
//

import UIKit

class BeneficiaryListVC: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var notFoundView: UIView!
    @IBOutlet weak var btnAddBeneficary: UIButton!
    
    let tableData : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        btnAddBeneficary.layer.cornerRadius = 8
    }
    

    @IBAction func btnBackFunc(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK : TableView Functions
extension BeneficiaryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableData.isEmpty {
            tableView.isHidden = true
            notFoundView.isHidden = false
        }
        else{
            tableView.isHidden = false
            notFoundView.isHidden = true
        }
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficaryTableCell") as! BeneficaryTableCell
        cell.mainView.layer.cornerRadius = 8
        cell.lblTitle.text = "Test"
        cell.lblSubtitle.text = "Account no. 123456789"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
